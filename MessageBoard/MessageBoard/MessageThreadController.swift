//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Nikita Thomas on 10/23/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation


class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    static var baseURL = URL(string: "https://lambda-chat-project.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (String) -> Void) {
        let messageThread = MessageThread(title: title)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        
        var urlRequest = URLRequest(url: requestURL)
        
        urlRequest.httpMethod = "PUT"
        
        // Don't know what/why/how this next code is doing
        do {
            urlRequest.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            completion("Could not encode data")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
           
            if let error = error {
                completion("Could not create URLSession.dataTask: \(error)")
                return
            }
            
            self.messageThreads.append(messageThread)
            completion("All good")
        }
        
        dataTask.resume()
    }
    
    func createMessage(thread: MessageThread, text: String, sender: String, completion: @escaping (String) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        let requestURL = MessageThreadController.baseURL.appendingPathComponent(thread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "POST"
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(message)
        } catch {
            completion("Could not encode message")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion("Could not create dataTask for message: \(error)")
                return
            }
            thread.messages.append(message)
            completion("All Good2")
        }
        dataTask.resume()
    }
    
    
}
