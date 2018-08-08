//
//  MessageThreadController.swift
//  ios-message-board
//
//  Created by De MicheliStefano on 08.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func createMessageThread(withTitle title: String, completion: @escaping (Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            NSLog("Unable to encode \(messageThread): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error posting data: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    func createMessage(for messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Unable to encode \(message): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error posting data: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
}
