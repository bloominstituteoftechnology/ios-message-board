//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Daniela Parra on 9/12/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    func createMessageThread (title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.put.rawValue
        
        
        //Do I set this data to the http body?
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            fatalError("Error encoding message thread: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error creating message thread: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            //could be error we don't know
            let responseString = String(data: data, encoding: .utf8)!
            NSLog(responseString)
            
            self.messageThreads.append(messageThread)
            completion(nil)
            
        }.resume()

    }
    
    func fetchMessageThreads
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    var messageThreads: [MessageThread] = []
}
