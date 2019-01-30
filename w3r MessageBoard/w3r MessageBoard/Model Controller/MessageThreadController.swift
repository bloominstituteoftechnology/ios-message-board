//
//  MessageThreadController.swift
//  w3r MessageBoard
//
//  Created by Michael Flowers on 1/30/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    //create a method to create and send a messageThread to the API. This method will use PUT as its HTTP method
    
    func createMessageThread(with title: String, completion: @escaping (Error?) -> Void){
        let newMT = MessageThread(title: title)
        
        //create url
        let url = MessageThreadController.baseURL.appendingPathComponent(newMT.identifier).appendingPathExtension("json")
        
        //create urlRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        //encode the MessageThread object you just initialized using JSON
        
        do {
            let jE = JSONEncoder()
            //we want to put the model object inside of the httpBody.
           urlRequest.httpBody =  try jE.encode(newMT)
            completion(nil)
        } catch  {
            print("Error encoding data into json: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("Error Putting data to API: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            //I DONT UNDERSTAND WHATS GOING ON HERE******************************************************************************************************************************************************************************************************************
            self.messageThreads.append(newMT)
            
        }.resume()
    }
    
    func createMessage(with messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void){
        let mtm = MessageThread.Message(text: text, sender: sender)
        
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathComponent("messages")
            .appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        do {
            let jE = JSONEncoder()
            //we want to put the model object inside of the httpBody.
            urlRequest.httpBody =  try jE.encode(mtm)
            completion(nil)
        } catch  {
            print("Error encoding data into json: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("Error POSTING dat to the API: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            //append the MessageThread from the parameter.
            messageThread.messages.append(mtm)
        }
        
    }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void){
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching data from the API: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do{
                let jd = JSONDecoder()
                //At the highest level, the MessageThreads are the VALUES of the UUID string KEYS. So we have to decode the JSON as [ String: MessageThread].self...
               let messageThreadDictionaries = try jd.decode([String: MessageThread].self, from: data)
                
                //get the values out of this dictionary
                let messageThreads = messageThreadDictionaries.map{$0.value}
                self.messageThreads = messageThreads
                completion(nil)
            }catch {
                print("Error decoding json: \(error.localizedDescription)")
                completion(error)
                return
            }
        }.resume()
    }

}
