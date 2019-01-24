//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Angel Buenrostro on 1/23/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    //NOTE: In order to access this baseURL, you must call the class MessageThreadController, then .baseURL because this is a static property.
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        var url = MessageThreadController.baseURL
        url = url.appendingPathComponent(messageThread.identifier)
        url = url.appendingPathExtension("json")
        
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
    
    func createMessage(messageThread : MessageThread, text: String, sender: String, completion: @escaping(Error?) -> Void) {
        let message = MessageThread.Message.init(text: text, sender: sender)
        var url = MessageThreadController.baseURL
        url = url.appendingPathComponent(messageThread.identifier)
        url = url.appendingPathComponent("messages")
        url = url.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(message)
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
            messageThread.messages.append(message)
            completion(nil)
        }.resume()
    }
}
