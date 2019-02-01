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
    
    
}





