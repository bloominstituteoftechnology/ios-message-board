//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Julian A. Fordyce on 1/23/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://message-board-3e056.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        var url = MessageThreadController.baseURL
        
        url.appendPathComponent(messageThread.identifier)
        url.appendPathComponent("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messageThread)
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
            
            completion(nil)
        }.resume()
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        
        var url = MessageThreadController.baseURL
        
        url.appendPathComponent(messageThread.identifier)
        url.appendPathComponent("messages")
        url.appendPathComponent("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(newMessage)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            messageThread.messages.append(newMessage)
            completion(nil)
        }.resume()
        
        
    }
}
