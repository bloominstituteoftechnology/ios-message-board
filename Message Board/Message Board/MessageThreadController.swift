//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Ryan Murphy on 5/15/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads = [MessageThread]()
    
    static let baseURL = URL(string: "https://message-board-3b570.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        var url = MessageThreadController.baseURL
        url.appendPathComponent(messageThread.identifier)
        url.appendPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = HTTPMethod.put.rawValue

        do{
            let jsonEncoder = JSONEncoder()
            requestURL.httpBody = try jsonEncoder.encode(messageThreads)
        }catch {
            NSLog("Error encoding Message Thread: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            if let error = error {
                NSLog("Error Putting data: \(error)")
            }
            self.messageThreads.append(messageThread)
            completion(nil)
        }.resume()
       
        
    }
   
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        // Will this be an issue with the init from MessageThread.swift?
        let message = MessageThread.Message.init(text: text, sender: sender)
        
        var url = MessageThreadController.baseURL
        url.appendPathComponent(messageThread.identifier)
        url.appendPathComponent("messages")
        url.appendPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
            requestURL.httpBody = try jsonEncoder.encode(message)
        } catch {
            print("Error encoding message to JSON: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            
            if let error = error {
                print("Error POSTing message: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            messageThread.messages.append(message)
            completion(nil)
            }.resume()
    }

}






enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}
