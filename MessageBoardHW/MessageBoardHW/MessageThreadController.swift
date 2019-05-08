//
//  MessageThreadController.swift
//  MessageBoardHW
//
//  Created by Michael Flowers on 5/8/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")! //yes we do need the "/" after the .com
    
    //you wll now make the method to create and send a MessageThread to the API.
    
    func createMessageThread(with title: String, completion: @escaping ()-> Void){
        //initialize a new MessageThread
        let newMT = MessageThread(title: title)
        
        //create your url using the thread's identfier property, this will let us put the thread at a unique location in the APi
        let url = MessageThreadController.baseURL.appendingPathComponent(newMT.identifier).appendingPathExtension("json") // we dont need to put that dot or . in the quotations
        
        //create a url request with the url I just created and set its method to put
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        //encode the data inside the httpbody
        do {
            let je = JSONEncoder()
            urlRequest.httpBody = try je.encode(newMT)
        } catch  {
            print("Error encoding data into the httpBody: \(error.localizedDescription)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("Error inside the data task: \(error.localizedDescription)")
                completion()
                return
            }
            
            //if there is no error then append the MessageThread objcet to the messageThread variable
            self.messageThreads.append(newMT)
            completion()
        }.resume()
    }
    
    //you now need a method to create messages within the messageThread
    
    func createMessage(with messageThread: MessageThread, text: String, sender: String, completion: @escaping ()-> Void){
        //initialize a messageThread.message object
        let mtm = MessageThread.Message(text: text, sender: sender)
        
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        
        //now that we have the url constructed we can create the url request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        //now that we have the httpMethod we can configure the body
        
        do {
            let je = JSONEncoder()
           urlRequest.httpBody =  try je.encode(mtm) //this is the data we want to send to the server
        } catch  {
            print("Error encoding the message into the httpBody: \(error.localizedDescription)")
            completion()
            return
        }
        
        //now that we have the url, urlREquest, and httpBody set to the data we can make our network call
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("Error inside the createMessageFunction data task: \(error.localizedDescription)")
                completion()
                return
            }
            
            //if there was no error, then append the MessageThread.Message Object to the MessageThread.Message variable. Since the MessageThread is a class, you can directly append it to its array of messages here.
            messageThread.messages.append(mtm)
            completion()
        }
    }
}
