//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Jeremy Taylor on 8/8/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(withTitle title: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread(title: title)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(message.identifier).appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        do {
            let jsonEncoder = JSONEncoder()
            let messageThread = try jsonEncoder.encode(message)
            urlRequest.httpBody = messageThread
        } catch {
            NSLog("Error encoding message: \(error)")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            
            self.messageThreads.append(message)
            completion(nil)
            
        }.resume()
    }
    
    func createMessage(in messageThread: MessageThread, with text: String, and sender: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        
    }
}
