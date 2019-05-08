//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Jeffrey Carpenter on 5/8/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads = [MessageThread]()
    
    static let baseURL = URL(string: "https://message-board-3b570.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        var url = MessageThreadController.baseURL
        url.appendPathComponent(messageThread.identifier)
        url.appendPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "PUT"
        
        do {
            let jsonEncoder = JSONEncoder()
            requestURL.httpBody = try jsonEncoder.encode(messageThread)
        } catch {
            print("Error encoding messageThread to JSON: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            
            if let error = error {
                print("Error PUTting data: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(nil)
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        let message = MessageThread.Message(text: text, sender: sender)
        
        var url = MessageThreadController.baseURL
        url.appendPathComponent(messageThread.identifier)
        url.appendPathComponent("messages")
        url.appendPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
            requestURL.httpBody = try jsonEncoder.encode(message)
        } catch {
            print("Error encoding message to JSON: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            
            if let error = error {
                print("Error POSTing message: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            messageThread.messages.append(message)
            completion(nil)
        }.resume()
    }
}
