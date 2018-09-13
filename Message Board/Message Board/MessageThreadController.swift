//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Moin Uddin on 9/12/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        //Create the new messageThread Object
        let messageThread = MessageThread(title: title)
        
        //Setup URL
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        //Encode JSON
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            fatalError("Error encoding messageThread \(messageThread): \(error)")
        }
        
        //Make API REQUEST
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Typical Error checking logic
            if let error = error {
                NSLog("Error POSTing new messageThread: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(error!)")
                completion(NSError())
                return
            }
            //Important part: Append the new messageThead if successful
            self.messageThreads.append(messageThread)
            print("Post Successful")
            completion(nil)
        }.resume()
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        //Create the new Message Object
        let message = MessageThread.Message(text: text, sender: sender)
        
        //Setup URL
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathComponent("messages")
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        //Encode JSON
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            fatalError("Error encoding message \(message): \(error)")
        }
        
        //Make API REQUEST
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Typical Error checking logic
            if let error = error {
                NSLog("Error posting new message: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task: \(error!)")
                completion(NSError())
                return
            }
            //Important part: Append the new message to the messageThread if successful
            messageThread.messages.append(message)
            print("Post Successful")
            completion(nil)
        }.resume()
        
    }
    
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    var messageThreads: [MessageThread] = []
}
