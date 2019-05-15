//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Mitchell Budge on 5/15/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func createMessageThread(with title: String, completion: @escaping (Error?) -> Void) {
        let newThread = MessageThread(title: title)
        
        var url = MessageThreadController.baseURL
        url.appendPathComponent(newThread.identifier)
        url.appendPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(newThread)
        } catch {
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    } // end of create message thread
    
    func createMessage(newThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        
        var url = MessageThreadController.baseURL
        
        url.appendPathComponent(newThread.identifier)
        url.appendPathComponent("messages")
        url.appendPathExtension("json")
        
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
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            newThread.messages.append(newMessage)
            completion(nil)
        }.resume()
    } // end of create message
}
