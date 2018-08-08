//
//  MessageThreadController.swift
//  ios-message-board
//
//  Created by Conner on 8/8/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(newMessage)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Could not create new message: \(error)")
                completion(error)
                return
            }
            
            messageThread.messages.append(newMessage)
            completion(nil)
        }.resume()
    }
    
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with request: \(error)")
                completion(error)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(nil)
        }.resume()
    }
    
    // MARK: - Properties
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    var messageThreads: [MessageThread] = []
}
