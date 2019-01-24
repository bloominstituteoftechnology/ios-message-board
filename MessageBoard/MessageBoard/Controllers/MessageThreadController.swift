//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Angel Buenrostro on 1/23/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    //NOTE: In order to access this baseURL, you must call the class MessageThreadController, then .baseURL because this is a static property.
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void){
        var url = MessageThreadController.baseURL
        url = url.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let messageThreadDictionaries = try decoder.decode([String: MessageThread].self, from: data)
                let messageThreads = Array(messageThreadDictionaries.values)
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        messageThreads.append(messageThread)
        var url = MessageThreadController.baseURL
        url = url.appendingPathComponent(messageThread.identifier)
        url = url.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messageThread)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func createMessage(messageThread : MessageThread, text: String, sender: String, completion: @escaping(Error?) -> Void) {
        let message = MessageThread.Message.init(text: text, sender: sender)
        var url = MessageThreadController.baseURL
        url = url.appendingPathComponent(messageThread.identifier)
        url = url.appendingPathComponent("messages")
        url = url.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(message)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            messageThread.messages.append(message)
            completion(nil)
        }.resume()
    }
}
