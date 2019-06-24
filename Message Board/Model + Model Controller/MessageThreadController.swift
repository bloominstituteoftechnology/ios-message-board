//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Jason Modisett on 9/12/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    func createMessageThread(with title: String, completion: @escaping (Error?) -> (Void)) {
        let messageThread = MessageThread(title: title)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent(".json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    NSLog("Error PUTing message thread title in Firebase: \(error)")
                    completion(error)
                }
                
                self.messageThreads.append(messageThread)
                
                NSLog("PUT successful")
                completion(nil)
                
            }.resume()
            
        } catch {
            fatalError("Error encoding message thread title: \(error)")
        }
        
    }
    
    
    func createMessage(in thread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> (Void)) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(thread.identifier).appendingPathComponent("messages").appendingPathComponent(".json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    NSLog("Error POSTing message thread title in Firebase: \(error)")
                    completion(error)
                }
                
                thread.messages.append(message)
                
                NSLog("POST successful")
                completion(nil)
                
            }.resume()
            
        } catch {
            fatalError("Error encoding message: \(error)")
        }
    }
    
    
    func fetchMessageThreads(completion: @escaping (Error?) -> (Void)) {
        let url = MessageThreadController.baseURL.appendingPathComponent(".json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let _ = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error GETing data from Firebase: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from Firebase API")
                completion(NSError())
                return
            }
            
            let response = String(data: data, encoding: .utf8)
            if response == "null" {
                NSLog("No data to work with")
                completion(nil)
                return
            }
                
            do {
                let jsonDecoder = JSONDecoder()
                let messageThreadDictionaries = try jsonDecoder.decode([String: MessageThread].self, from: data)
                self.messageThreads = messageThreadDictionaries.map { $0.value }
                completion(nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
}
