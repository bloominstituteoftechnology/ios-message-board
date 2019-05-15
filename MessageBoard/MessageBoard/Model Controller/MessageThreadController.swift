//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Jeremy Taylor on 5/15/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func createMessageThread(withTitle title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            let messageThread = try jsonEncoder.encode(messageThread)
            urlRequest.httpBody = messageThread
        } catch {
            NSLog("Error encoding message thread: \(error)")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(nil)
            
            }.resume()
    }
    
    func createMessage(in messageThread: MessageThread, withText text: String, andSender sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            let message = try jsonEncoder.encode(newMessage)
            urlRequest.httpBody = message
            
        } catch {
            NSLog("Error encoding message: \(error)")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            messageThread.messages.append(newMessage)
            completion(nil)
            
            }.resume()
        
    }
}
