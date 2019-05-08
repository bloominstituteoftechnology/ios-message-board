//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Christopher Aronson on 5/8/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThread: [MessageThread] = []
    static let baseURL = URL(string: "https://put-and-post-9d7da.firebaseio.com/")!
    
    // MARK: - createMessageThread()
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread(title: title)
        var url = MessageThreadController.baseURL
        
        url.appendPathExtension(message.identifier)
        url.appendPathExtension(".json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(message)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            self.messageThread.append(message)
            
            completion(nil)
        }.resume()
    }
    
    // MARK: - CreateMessage()
    func createMessage(parentThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        var url = MessageThreadController.baseURL
        
        url.appendPathExtension(parentThread.identifier)
        url.appendPathExtension("messages")
        url.appendPathExtension(".json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(newMessage)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            parentThread.messages.append(newMessage)
            
            completion(nil)
            }.resume()
    }
    
}
