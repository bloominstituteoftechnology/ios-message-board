//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Scott Bennett on 9/19/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            NSLog("Error encoding thread \(messageThread): \(error)")
        }
        // Create the data task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with dataTask \(error)")
                completion(error)
            }
            
            self.messageThreads.append(messageThread)
            completion(nil)
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        let message = MessageThread.Message(text: text, sender: sender)
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathComponent("messages")
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Error encoding message \(message): \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with dataTask \(error)")
                completion(error)
                return
            }
            
            messageThread.messages.append(message)
            completion(nil)
            return
        }.resume()
        
    }
    
    func fetchMessagesThread(completion: @escaping (Error?) -> Void) {
        
        var requestURL = MessageThreadController.baseURL
        requestURL.appendPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error with dataTask \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from dataTask.")
                completion(error)
                return
            }
            
            do {
                let messageThreadDictionaries = try JSONDecoder().decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map( { $0.value })
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                NSLog("Error decoding data in fetchMessagesThread: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
        
}
