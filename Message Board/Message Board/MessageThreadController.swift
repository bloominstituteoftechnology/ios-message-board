//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Nathanael Youngren on 1/23/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let newMessageThread = MessageThread(title: title)
        
        let threadURL = MessageThreadController.baseURL.appendingPathComponent(newMessageThread.indentifier)
        
        let jsonThreadURL = threadURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: jsonThreadURL)
        urlRequest.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        
        do {
            urlRequest.httpBody = try encoder.encode(newMessageThread)
        } catch {
            print(NSError())
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            self.messageThreads.append(newMessageThread)
            completion(nil)
        }.resume()
        
    }
    
}
