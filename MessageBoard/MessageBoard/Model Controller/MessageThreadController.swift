//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Christopher Aronson on 5/8/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThread: [MessageThread] = []
    static let baseURL = URL(string: "https://put-and-post-9d7da.firebaseio.com/")!
    
    // MARK: - createMessageThread()
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread(title: title)
        let url = MessageThreadController.baseURL
        
        var urlWithIdentifier = url.appendingPathComponent(message.identifier)
        urlWithIdentifier.appendPathExtension("json")
        
        var request = URLRequest(url: urlWithIdentifier)
        request.httpMethod = "PUT"
        print(request)
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
            
            self.messageThread.append(message)
            
            completion(nil)
        }.resume()
    }
    
    // MARK: - CreateMessage()
    func createMessage(parentThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        let url = MessageThreadController.baseURL
        
        let urlWithIdentifier = url.appendingPathComponent(parentThread.identifier)
        var urlWithMessages = urlWithIdentifier.appendingPathComponent("messages")
        urlWithMessages.appendPathExtension("json")
        
        var request = URLRequest(url: urlWithMessages)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(newMessage)
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
            
            parentThread.messages.append(newMessage)
            
            completion(nil)
            }.resume()
    }
    
    //MARK: - fetchMessageThreads()
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        var url = MessageThreadController.baseURL
        
        url.appendPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Could not fetch data")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let messageThreadDictionary = try decoder.decode([String: MessageThread].self, from: data)
                let messages = Array(messageThreadDictionary.values)
                self.messageThread = messages
                completion(nil)
            } catch {
                print("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    
    
    
    
}
