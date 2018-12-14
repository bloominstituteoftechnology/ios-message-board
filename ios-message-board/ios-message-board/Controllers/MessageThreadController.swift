//
//  MessageThreadController.swift
//  ios-message-board
//
//  Created by Austin Cole on 12/13/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://put-and-post-d7612.firebaseio.com/")
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        print(message)
        
        let appendedURL = MessageThreadController.baseURL?.appendingPathComponent((messageThread.identifier))
        let moreAppendedURL = appendedURL?.appendingPathComponent("messages")
        let extendedURL = moreAppendedURL?.appendingPathExtension("json")
        var requestURL = URLRequest(url: extendedURL!)
        
        requestURL.httpMethod = "POST"
        
        do {
            requestURL.httpBody = try JSONEncoder().encode(message)
            completion(nil)
        }catch {
            NSLog("Failed to encode \"PUT\" data.")
            completion(NSError())
            return
        }
        //MARK: "PUT" data using Data Task
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error with method \"PUT\" in dataTask.")
                completion(error)
                return
            }
            messageThread.messages.append(message)
            //completion(nil) <-- Calling `completion` right here gave me an error. It would go to this line before it went to append `messages`, somehow resulting in the latter not happening.
        }
        dataTask.resume()
    }
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        // MARK: Put together URL Request
        let appendedURL = MessageThreadController.baseURL?.appendingPathComponent((messageThread.identifier))
        let extendedURL = appendedURL?.appendingPathExtension("json")
        var requestURL = URLRequest(url: extendedURL!)
        
        requestURL.httpMethod = "PUT"
        
        //MARK: Encode JSON data
        
        do {
        requestURL.httpBody = try JSONEncoder().encode(messageThread)
            completion(nil)
        }catch {
            NSLog("Failed to encode \"PUT\" data.")
            completion(NSError())
            return
        }
        //MARK: "PUT" data using Data Task
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error with method \"PUT\" in dataTask.")
                completion(error)
                return
            }
            self.messageThreads.append(messageThread)
            
        }
        dataTask.resume()
        
    }
    
    func fetchThreads(completion: @escaping (Error?) -> Void) {
        
        // Construct URL
        let appendedURL = MessageThreadController.baseURL?.appendingPathExtension("json")
        
        //call Data Task
        let dataTask = URLSession().dataTask(with: appendedURL!) { (data, _, error) in
            if let error = error {
                NSLog("Error with dataTask in fetchThreads.")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("Error fetching data.")
                completion(NSError())
                return
            }
            do {
                let messageThreadDictionaries = try JSONDecoder().decode([String : MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries
            }
            catch {
            }
        }
    }
    
}

