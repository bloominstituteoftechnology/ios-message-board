//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/15/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messageThread)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(newMessage)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
//    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
//        let url = MessageThreadController.baseURL.appendingPathExtension("json")
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                completion(error)
//                return
//            }
//            guard let data = data else {
//                completion(NSError())
//                return
//            }
//            let jsonDecoder = JSONDecoder()
//            let messageResults = try decoder.decode([Message].self, from: data)
//
//        }
//    }
    
} // MessageThreadController class End
