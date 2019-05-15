//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Kobe McKee on 5/15/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
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
    
    
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let newThread = MessageThread(title: title)
        
        let threadURL = MessageThreadController.baseURL.appendingPathComponent(newThread.identifier)
        let formattedURL = threadURL.appendingPathExtension("json")
        
        var request = URLRequest(url: formattedURL)
        let method = HTTPMethod.put
        request.httpMethod = method.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(newThread)
        } catch {
            NSLog("Error encoding message thread: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error pushing thread to Firebase: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
        
    }
    
    
    
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
    
        let newMessage = MessageThread.Message(text: text, sender: sender)
        
        let messageURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        let formattedURL = messageURL.appendingPathComponent("messages")
        let finishedURL = formattedURL.appendingPathExtension("json")
        
        var request = URLRequest(url: finishedURL)
        let method = HTTPMethod.post
        request.httpMethod = method.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(newMessage)
        } catch {
            NSLog("Error encoding message: \(error)")
            completion(error)
        }
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error pushing message to Firebase: \(error)")
                completion(error)
            }
            messageThread.messages.append(newMessage)
            completion(nil)
        }.resume()
        
        
    }
    
    
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        
        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching threads: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let messageThreadDictionaries = try decoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ $0.value })
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                NSLog("Error decoding threads: \(error)")
                completion(error)
            }
        }.resume()
        
        
        
        
    }
    
    
    
    
    
    
    
}


