//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Nathanael Youngren on 1/23/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://message-board-3e056.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let newMessageThread = MessageThread(title: title)
        
        let threadURL = MessageThreadController.baseURL.appendingPathComponent(newMessageThread.indentifier)
        
        let jsonThreadURL = threadURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: jsonThreadURL)
        urlRequest.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        
        do {
            urlRequest.httpBody = try encoder.encode(newMessageThread)
        } catch {
            print(NSError())
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            self.messageThreads.append(newMessageThread)
            completion(nil)
        }.resume()
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        let newMessage = MessageThread.Message(text: text, sender: sender)
        
        let messageThreadURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.indentifier)
        
        let messagesURL = messageThreadURL.appendingPathComponent("messages")
        
        let jsonURL = messagesURL.appendingPathExtension("json")
        
        var requestURL = URLRequest(url: jsonURL)
        requestURL.httpMethod = "POST"
        
        let jsonEncoder = JSONEncoder()
        
        do {
            requestURL.httpBody = try jsonEncoder.encode(newMessage)
        } catch {
            print(NSError())
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            messageThread.messages.append(newMessage)
            completion(nil)
            }.resume()
    }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
    
            do {
                let messageThreadDictionaries = try decoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ $0.value })
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                print(error)
                completion(error)
                return
            }
        }.resume()
        
    }
    
}
