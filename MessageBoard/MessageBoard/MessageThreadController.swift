//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Yvette Zhukovsky on 10/23/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    func createMessageThread(title: String, with completion: @escaping (Error?)-> Void) {
        
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.PUT.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error posting data: \(error)")
                completion(error)
            }
            completion(nil)
        }
        dataTask.resume()
    }
        
        func createMessage(for messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
            let message = MessageThread.Message(text: text, sender: sender)
            let url = MessageThreadController.baseURL
                .appendingPathComponent(messageThread.identifier)
                .appendingPathComponent("messages")
                .appendingPathExtension("json")
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.POST.rawValue
            
            do {
                request.httpBody = try JSONEncoder().encode(message)
            } catch {
                NSLog("Unable to encode \(message): \(error)")
                completion(error)
                return
            }
            
           let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    NSLog("Error posting data: \(error)")
                    completion(error)
                }
                completion(nil)
                }
            dataTask.resume()
    }
            
            

    
    func fetchMessageThreads {
        
        
    }
        
        
        
        
        var messageThreads: [MessageThread] = []
        static let baseURL: URL! = URL(string: "https://lambda-chat-project.firebaseio.com/")!
        


}
