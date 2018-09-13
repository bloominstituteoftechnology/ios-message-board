//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Dillon McElhinney on 9/12/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class MessageThreadController {
    private(set) var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void ) {
        let messageThread = MessageThread(title: title)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            fatalError("Error encoding message thread data: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error PUTting message thread: \(error)")
                completion(error)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(nil)
            
        }.resume()
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void ) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathComponent("messages")
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            fatalError("Error encoding message data: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error POSTing message to thread: \(error)")
                completion(error)
                return
            }
            
            messageThread.messages.append(message)
            completion(nil)
            
        }.resume()
        
    }
    
    func fetchMessageThreads(completion: @escaping () -> Void ) {
        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching message threads: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned")
                completion()
                return
            }
            
            do {
                let messageThreadsDictionary = try JSONDecoder().decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadsDictionary.map( { $0.value } )
                self.messageThreads = messageThreads
                completion()
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion()
            }
        }.resume()
    }
    
}
