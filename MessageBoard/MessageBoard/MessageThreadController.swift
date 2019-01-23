//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Jocelyn Stuart on 1/23/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []

    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(withTitle title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        
        MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        MessageThreadController.baseURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: MessageThreadController.baseURL)
        urlRequest.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(messageThread)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            self.messageThreads.append(messageThread)
            completion(nil)
        }.resume()
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        MessageThreadController.baseURL.appendingPathComponent("messages")
        MessageThreadController.baseURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: MessageThreadController.baseURL)
        urlRequest.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(message)
        } catch {
            print(error)
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
          //  self.MessageThread.messages.append(message)
            completion(nil)
            }.resume()
        
        
        
    }
    
    
    
}
