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
    
    func createMessageThread (title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = [], completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.PUT.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            fatalError("#1 Error encoding message thread")
        }
        
        URLSession.shared.dataTask(with: request) { (Data, _, error) -> Void in
            if let error = error {
                NSLog("#2 Error sending data: \(error)")
                completion(error)
                return
            
            }
            self.messageThreads.append(messageThread)
            completion(nil)
            
        }.resume()
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        guard let index = messageThreads.index(of: messageThread) else {
            completion(NSError())
            return
        }
        let message = MessageThread.Message(text: text, sender: sender)
        messageThreads[index].messages.append(message)
        
        let appendRequestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
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
        
        URLSession.shared.dataTask(with: request) { (Data, _, error) in
            if let error = error {
                NSLog("#5 Error sending message data: \(error)")
                completion(error)
                return
            }
        completion(nil)
        }.resume()
    }
    
    /// Fetch ///
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        
        var fetchUrl = MessageThreadController.baseURL
        fetchUrl.appendPathExtension("json")
        
        URLSession.shared.dataTask(with: fetchUrl) {(Data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            guard let data = Data else {
                NSLog("No data returned from fetch")
                completion(NSError())
                return
            }
            
            let messageDecoder = JSONDecoder()
            messageDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let messageDecoder = JSONDecoder()
                let messageThreadDictionaries = try messageDecoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map( {$0.value} )
                self.messageThreads = messageThreads
                completion(nil)
                
            } catch {
                NSLog("Unable to decode data into itunes search results: \(error)")
                completion(error)
                return
            
            }
        }.resume()
    }
    
}

