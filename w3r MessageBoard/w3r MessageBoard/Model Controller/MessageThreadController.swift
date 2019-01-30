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
        messageThreads.append(newMT)
        
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

}
