//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Carolyn Lea on 8/8/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

class MessageThreadController
{
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    var messageThreads: [MessageThread] = []
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void)
    {
       let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("Error saving messageThread on server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
        .resume()
    }
   
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void)
    {
        let aMessageThread = MessageThread.Message(text: text, sender: sender)
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("Error saving messageThread on server: \(error)")
                completion(error)
                return
            }
            else
            {
                messageThread.messages.append(aMessageThread)
            }
            completion(nil)
        }
        .resume()
    }
    
    
    
    
    
    
}
