//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    // MARK: - Properties
    
    var messageThreads: [MessageThread] = []
    
    // MARK: - Base URL
    
    static let baseURL = URL(string: "https:/lambda-message-board.firebaseio.com")!
    
    // MARK: - Create and send a MessageThread to the API
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let newMessageThread = MessageThread(title: title)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(newMessageThread.identifier)
        let newURL = url.appendingPathExtension("json")
        
        var request = URLRequest(url: newURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            let messageThread = try JSONEncoder().encode(newMessageThread)
            request.httpBody = messageThread
        } catch {
            NSLog("Error encoding \(newMessageThread): \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error putting data: \(error)")
                completion(error)
                return
            }
            
            self.messageThreads.append(newMessageThread)
            completion(nil)
        }.resume()
    }
    
    // MARK: - Create Messages within a MessageThread
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        let newURL = url.appendingPathComponent("messages")
        let lastURL = newURL.appendingPathExtension("json")
        
        var request = URLRequest(url: lastURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            let message = try JSONEncoder().encode(newMessage)
            request.httpBody = message
        } catch {
            NSLog("Error encoding \(newMessage): \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error posting data: \(error)")
                completion(error)
                return
            }
            
            messageThread.messages.append(newMessage)
            completion(nil)
        }.resume()
    }
}
