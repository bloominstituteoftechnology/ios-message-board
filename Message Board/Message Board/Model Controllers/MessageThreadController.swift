//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Linh Bouniol on 8/8/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    // MARK: - Methods
    
    // Make methods to create and send MessageThread to the API. The method will use PUT as its httpMethod.
    
    func createMessageThread(withTitle title: String, completion: @escaping (Error?) -> Void) {
        
        // Initialize a new MessageThread object
        let messageThread = MessageThread(title: title)
        
        // Use appendingPathComponent to put the thread at a unique location in the API. Firebase API requires "json" at the end of the path
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error) // Safe
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error saving message thread to server: \(error)")
                DispatchQueue.main.async {
                    completion(error) // Should be on main
                }
                return
            }
            DispatchQueue.main.async {
                self.messageThreads.append(messageThread) // Should be on main (it is)
                completion(nil) // Should be on main (it is)
            }   
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        let message = MessageThread.Message(text: text, sender: sender)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Unable to encode \(message): \(error)")
            completion(error) // safe
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error saving message to server: \(error)")
                DispatchQueue.main.async {
                    completion(error) // Should be on main
                }
                return
            }
            DispatchQueue.main.async {
                messageThread.messages.append(message) // Should be on main
                completion(nil) // Should be on main
            }
        }.resume()
    }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error saving message to server: \(error)")
                DispatchQueue.main.async {
                    completion(error) // Should be on main
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(error) // Should be on main
                }
                return
            }
            
            do {
                let messageThreadDictionaries = try JSONDecoder().decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ $0.value })
                
                DispatchQueue.main.async {
                    self.messageThreads = messageThreads // Should be on main (it is)
                }
                
            } catch {
                NSLog("Error decoding received data: \(error)")
                DispatchQueue.main.async {
                    completion(error) // Should be on main
                }
                return
            }
            DispatchQueue.main.async {
                completion(error) // Should be on main
            }
        }.resume()
    }
}
