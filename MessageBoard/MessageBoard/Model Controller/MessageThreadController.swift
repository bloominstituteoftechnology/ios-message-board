//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Paul Yi on 1/30/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (_ success: Bool) -> Void) {
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
    
    func createMessage(thread: MessageThread, text: String, sender: String, completion: @escaping (_ success: Bool) -> Void) {
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
    
    func fetchMessageThreads(completion: @escaping (_ success: Bool) -> Void) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not received.")
                completion(false)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let messageThreadDictionaries = try jsonDecoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ $0.value })
                self.messageThreads = messageThreads
                completion(true)
                
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(false)
                return
            }
        }.resume()
    }
}





