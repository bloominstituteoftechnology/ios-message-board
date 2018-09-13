//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Dillon McElhinney on 9/12/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    // MARK: - Properties
    private(set) var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    // MARK: - API Methods
    /// Creates a message thread from a given title. Makes a PUT request to the API, and if it is successful, adds the message thread to the messageThreads array. Calls a completion handler when it is done, with an error if there is one or nil if successful.
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void ) {
        let messageThread = MessageThread(title: title)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            fatalError("Error encoding message thread data: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error PUTting message thread: \(error)")
                completion(error)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(nil)
            
        }.resume()
        
    }
    
    /// Creates a message on a given messageThread from a given text and sender. Makes a POST request to the API, and if it is successful, adds the message to the message thread. Calls a completion handler when it is done, with an error if there is one or nil if successful.
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void ) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathComponent("messages")
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            fatalError("Error encoding message data: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error POSTing message to thread: \(error)")
                completion(error)
                return
            }
            
            messageThread.messages.append(message)
            completion(nil)
            
        }.resume()
        
    }
    
    /// Fetches all the current message threads and associated message from the network. Makes a GET request to the API, and if it is successful, sets the messageThreads array to the returned message threads. Calls a completion handler when it is done, with an error if there is one or nil if successful.
    func fetchMessageThreads(completion: @escaping (Error?) -> Void ) {
        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching message threads: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned")
                completion(NSError())
                return
            }
            
            do {
                let messageThreadsDictionary = try JSONDecoder().decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadsDictionary.map( { $0.value } )
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(error)
            }
        }.resume()
    }
    
}
