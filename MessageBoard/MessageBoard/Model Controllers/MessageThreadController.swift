//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by morse on 5/8/19.
//  Copyright © 2019 morse. All rights reserved.
//
enum PushMethod: String {
    case post = "POST"
    case put = "PUT"
}

import Foundation

class MessageThreadController {
    static let baseURL = URL(string: "https://djm-message-board.firebaseio.com/")!
    var messageThreads: [MessageThread] = []
    
    // It looks like the instructions are combining the create and push functions.
    
    func createMessageThread(title: String/*, using method: PushMethod*/, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        var url = MessageThreadController.baseURL
        
        url.appendPathComponent(messageThread.identifier)
        url.appendPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = PushMethod.put.rawValue
        
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
            } else {
                self.messageThreads.append(messageThread)
                print("Request: \(request)")
                completion(nil)
            }
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        var url = MessageThreadController.baseURL
        
        url.appendPathComponent(messageThread.identifier)
        url.appendPathComponent("messages")
        url = url.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = PushMethod.post.rawValue
        
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
            } else {
                messageThread.messages.append(message)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let messageThreadDictionaries = try jsonDecoder.decode([String: MessageThread].self, from: data)
                let messageThreads = Array(messageThreadDictionaries.values)
                self.messageThreads = messageThreads.sorted { $0.title < $1.title }
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    
}
