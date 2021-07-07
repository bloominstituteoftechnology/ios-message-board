//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Simon Elhoej Steinmejer on 08/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!

class MessageThreadController
{
    var messageThreads: [MessageThread] = []
    
    func createMessageThread(title: String, completion: @escaping () -> ())
    {
        let messagethread = MessageThread(title: title)
        
        let url = baseURL
            .appendingPathComponent(messagethread.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messagethread)
            
        } catch {
            NSLog("Failed to encode messageThread object to JSON \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error
            {
                NSLog("URLSession failed: \(error)")
                return
            }
            self.messageThreads.append(messagethread)
            completion()
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping () -> ())
    {
        let message = MessageThread.Message(text: text, sender: sender)
        
        let url = baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
            
        } catch {
            NSLog("Failed to encode messageThread object to JSON \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error
            {
                NSLog("URLSession failed: \(error)")
                return
            }
            messageThread.messages.append(message)
            completion()
        }.resume()
    }
    
    func fetchMessageThreads(completion: @escaping () -> ())
    {
        let url = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error
            {
                NSLog("Failed to fetch message threads \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Failed to unwrap data")
                return
            }
            
            do
            {
                let jsonDecoder = JSONDecoder()
                let messageThreadDictionaries = try jsonDecoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ $0.value })
                self.messageThreads = messageThreads
                completion()
            } catch
            {
                NSLog("Failed to decode json object")
                return
            }
            
            
        }.resume()
    }
    
}


















