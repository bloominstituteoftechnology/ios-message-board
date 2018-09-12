//
//  MessageThreadController.swift
//  MessageBoard
//
//  Created by Farhan on 9/12/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation

class MessageThreadController{
    
    var messageThreads: [MessageThread] = []
    
    let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void){
        
        let messageThread = MessageThread(title: title)
        
        var requestURL =  baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        
//        print(requestURL.absoluteString) Test and see if URL is as needed
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do{
            request.httpBody = try JSONEncoder().encode(messageThread)
        }catch {
            NSLog("Data Encoding Error")
            completion(NSError())
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // CHECK ERROR STATUS IF TRANSPORT FAILED
            if let error = error {
                NSLog("Error initiating data task")
                completion(error)
                return
            }
            
            // CHECK DATA TO SEE IF YOU GOT THE RIGHT THING (SUCCESS MESSAGE)
            guard let data = data else {
                NSLog("Data PUT failed")
                completion(NSError())
                return
            }
            // PRINT SUCCESS / FAILURE MESSAGE
            let responseString = String(data: data, encoding: .utf8)!
            NSLog(responseString)
            
            
            self.messageThreads.append(messageThread)
            completion(nil)
            
        }.resume()
    }
    
    func createMessage (messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
//        guard let index = messageThread.identifier else {return}
        
        let message = MessageThread.Message(text: text, sender: sender, timestamp: Date())
        
        var requestURL =  baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages")
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Error Encoding Messages")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                NSLog("Error in POSTing messages: \(error)")
                completion(error)
                return
            }
            
//             If there was no error, then append the MessageThread.Message object to the MessageThread.Message variable. Since the MessageThread is a class, you can directly append it to its array of messages here. Remember to call completion, and resume the data task.
            
            messageThread.messages.append(message)
            completion(nil)
            
        }.resume()
    }
    
    
    
}



