//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Daniela Parra on 9/12/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        let message = MessageThread.Message(text: text, sender: sender)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        
        requestURL.appendPathExtension("messages")
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
            
        } catch {
            NSLog("Error encoding message: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error POSTing new message: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not received from service")
                completion(NSError())
                return
            }
            
            let response = String(data: data, encoding: .utf8)!
            NSLog(response)
            
            messageThread.messages.append(message)
            completion(nil)
            
        }.resume()
        
        
        
        
        
        
    }
    
}

