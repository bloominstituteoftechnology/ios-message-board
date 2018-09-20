//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Welinkton on 9/20/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!

    // create and send a message to the API
    // this will use PUT as its HTTP method
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        // initialize a new MessageThread object
        
        let messageThreads = MessageThread(title: title)
        
        // create a URL using the thread's identifier property.
        // add the identifier on the end of the URL
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThreads.identifier)
            // Example https://lambda-message-board.firebaseio.com/695398C4-498C-40A8-AA76-CB2B20DFD9FA/
        
        requestURL.appendPathExtension("json")
            // Example https://lambda-message-board.firebaseio.com/695398C4-498C-40A8-AA76-CB2B20DFD9FA/.json
        
        // name all that a simple variable
        var request = URLRequest(url: requestURL)
        
        // now take that ammended url and run PUT on it
        request.httpMethod = HTTPMethod.put.rawValue
        
        // Encode the MessageThread using JSONEncoder in a do-try-block
        do {
            let jsonEncoder = JSONEncoder()
                
            let jsonData = try jsonEncoder.encode(messageThreads)
            
            request.httpBody = jsonData
            
        } catch {
            fatalError("Error encoding message thread: \(error)")
        }
        
        // Perform a URLSessionDataTask
        
        URLSession.shared.dataTask(with: request) {(data, _, error) in
            if let error = error {
                NSLog("Error creating message thread: \(error)")
                completion(error)
                return
            }
            
            guard data != nil else {
                NSLog("No data returned")
                completion(NSError())
                return
            }
            self.messageThreads.append(messageThreads)
            completion(nil)
            
        }.resume()
        
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        guard let index = messageThreads.index(of: messageThread) else {completion(NSError()); return}
        
        let message = MessageThread.Message(text: text, sender: sender)
        
        //let requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        //requestURL.appendingPathComponent("messages")
        //requestURL.appendingPathExtension("json")
        
        let requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        

        
        do {
            request.httpBody = try JSONEncoder().encode(message)
            
        } catch {
            NSLog("Error encoding message: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, _, error) in
            if let error = error {
                NSLog("Error creating message \(error)")
                completion(nil)
                return
            }
            
//            guard data != nil else {
//                NSLog("No data was recieved")
//                completion(NSError())
//                return
//            }
            
            self.messageThreads[index].messages.append(message) // bring up below 79
            completion(nil)
            
        }.resume()
    }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void ) {
    
}
    
    
}
