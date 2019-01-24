//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Moses Robinson on 1/23/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://moses-lambda-message-board.firebaseio.com/")!

enum httpMethod: String {
    case put = "PUT"
    case post = "POST"
}

class MessageThreadController {
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        
        let url = baseURL.appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.put.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            urlRequest.httpBody = try jsonEncoder.encode(messageThread)
        } catch {
            NSLog("Could not encode messageThread")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("\(error): error was found.")
                completion(error)
                return
            }
            self.messageThreads.append(messageThread)
            completion(nil)
        }
        dataTask.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        let url = baseURL.appendingPathComponent(messageThread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.post.rawValue
        
        do {
            let jsonEncoder = JSONEncoder()
            urlRequest.httpBody = try jsonEncoder.encode(message)
        } catch {
            NSLog("error")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                NSLog("\(error) was found.")
                completion(error)
                return
            }
            messageThread.messages.append(message)
            completion(nil)
        }
        dataTask.resume()
    }
    
    func fecthMessageThreads(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("error getting data: \(error)")
                completion(error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    let messageThreadDictionaries = try jsonDecoder.decode([String : MessageThread].self, from: data)
                    let messageThreads = messageThreadDictionaries.map { $0.value }
                    self.messageThreads = messageThreads.sorted { $0.title.lowercased() < $1.title.lowercased() }
                    completion(nil)
                } catch {
                    NSLog("error decoding data")
                    completion(error)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    //MARk: - Properties
    
    private(set) var messageThreads: [MessageThread] = []
}
