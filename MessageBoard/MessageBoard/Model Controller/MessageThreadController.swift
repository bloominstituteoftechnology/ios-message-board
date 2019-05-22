//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @ escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        
        let requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messageThread)
        } catch {
            NSLog("Error encoding messageThread: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error pushing messageThread to firebase: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        let newMessage = MessageThread.Message(text: text, sender: sender)
        
        let requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(newMessage)
        } catch {
            NSLog("Error encoding newMessage: \(error)")
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error pushing newMessage to firebase: \(error)")
                completion(error)
                return
            }
            
            messageThread.messages.append(newMessage)
            completion(nil)
        }.resume()
        
    }
    
}
