//
//  messageThreadController.swift
//  MessageBoard Project
//
//  Created by Michael Flowers on 1/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    //set up the base url
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    //make a method to create and send a MessageThread to the API. This message will use PUT as its HTTP method
    
    func createMessageThread(with title: String, completion: @escaping (Error?) -> Void){
        
        let messageThread = MessageThread(title: title)
        
        //we need to create a URL using the thread's identifier property, this will let us put the thread at a unique location in the API
        let url = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        
        //set its httpMethod to put
        urlRequest.httpMethod = "PUT"
        
        //now encode the messageThread object you just initialized using jsonEncoder -- what is this doing?
        do {
            let je = JSONEncoder()
           urlRequest.httpBody =  try je.encode(messageThread)
            
        } catch  {
            print("Error decoding data: \(error.localizedDescription)")
            completion(error)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("Error PUTing the data: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            //there was no error so now i can append the messageThread to the data source of truth
            self.messageThreads.append(messageThread)
            completion(nil)
            
        }.resume()
      
    }
    
    //you now need a method to create message within a MessageThread
    func createMessage(with messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void ){
        
        //initialize a messageThread.message
        let mtm = MessageThread.Message(text: text, sender: sender)
        
        //create a url
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathComponent("json")
        
        //create a url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //encode our model object that we just initialized
        let jE = JSONEncoder()
        do {
           request.httpBody =  try jE.encode(mtm)
        } catch  {
            print("Error din the create message function: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        //now that I've created the url, created the urlRequest, and I have encoded the model object, I can start the urlSesstion
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error with the data task request function: \(error.localizedDescription)")
                completion(error)
                return
            }
            //if there was no error, then append the MEssageThread.Message object to the MEssageThread.Message variable. Since the MessageThread is a class, you can directly append it to its array of messages.
            messageThread.messages.append(mtm)
            completion(nil)
            
        }.resume()
    }
    
    func fetchMessageThread(completion: @escaping (Error?) -> Void)  {
        
        //create a url to get the data from
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in the fetch message data task: \(error.localizedDescription)")
                completion(error)
            }
            
            //unwrap the data using a jsondecoder
            guard let data = data else { return }
            do{
                let jD = JSONDecoder()
               let messageThreadDictionaries = try jD.decode([String: MessageThread].self, from: data) // json is a dictionary of string: and our type. We have to input the highest level in the json, which is usually our first model object
                
                //create a constant that will map through the messageThreadDictionaries and return only the values of each dictionary
                let messageThreads = messageThreadDictionaries.map({$0.value})
                
                //set the class's messageThreads variable to the messageThread you just made so the rest of the application can use the threads
                self.messageThreads = messageThreads
                completion(nil)
                
            } catch {
                print("Error in the fetch function: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
