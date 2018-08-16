//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Lisa Sampson on 8/15/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    func createMessageThread(title: String, completion: @escaping RequestCompletion) {
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            fatalError("Error encoding message thread: \(messageThread) \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(true)
            
            }.resume()
    }
    
    func createMessage(thread: MessageThread, text: String, sender: String, completion: @escaping RequestCompletion) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        let url = MessageThreadController.baseURL.appendingPathComponent(thread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(newMessage)
        } catch {
            fatalError("Error encoding message thread: \(newMessage) \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            thread.messages.append(newMessage)
            completion(true)
        }.resume()
    }
    
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    typealias RequestCompletion = (_ success: Bool) -> Void
    
}
