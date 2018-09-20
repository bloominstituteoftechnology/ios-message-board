//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Madison Waters on 9/19/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    private enum HTTPMethod: String {
        case GET = "GET"
        case PUT = "PUT"
        case POST = "POST"
        case DELETE = "DELETE"
    }
    
    func createMessageThread (title: String, identifier: String, completion: @escaping (Error?) -> Void) {
        
        var messageThreads: [MessageThread] = []
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent("identifier")
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.PUT.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThreads)
            return
        } catch {
            fatalError("#1 Error encoding message thread")
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (Data, _, error) in
            if let error = error {
                NSLog("#2 Error sending data: \(error)")
                completion(error)
                return
            }
            guard let data = Data else {
                NSLog("#3 Error sending data. Nothing sent")
                completion(NSError())
                return
            }
            messageThreads.append(MessageThread)
            if let error = error {
            completion(error)
            return
            }
        }.resume()
    }
    
    func createMessage(messageThread: [MessageThread], text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        var message: [MessageThread.Message] = []
        
        let appendRequestURL = MessageThreadController.baseURL.appendingPathComponent("identifier")
        var requestURL = appendRequestURL.appendingPathComponent("messages") // Should match the name of the MessageThread's array of messages property
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.POST.rawValue
        
        do {
          request.httpBody = try JSONEncoder().encode(message)
            return
        } catch {
            fatalError("#4 Error encoding message")
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (Data, _, error) in
            if let error = error {
                NSLog("#5 Error sending message data: \(error)")
                completion(error)
                return
            }
            guard let data = Data else {
                NSLog("#6 Error sending message data. Nothing sent")
                completion(NSError())
                return
            }
            message.append(MessageThread.Message)
            if let error = error {
            completion(error)
            return
            }
        }.resume()
    }

}

//Since the MessageThread is a class, you can directly append it to its array of messages here.
