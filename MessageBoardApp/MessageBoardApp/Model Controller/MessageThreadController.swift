//
//  MessageThreadController.swift
//  MessageBoardApp
//
//  Created by Nelson Gonzalez on 1/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation



class MessageThreadController {
    private(set) var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    
    //Create a function called createMessageThread. It should take in a title parameter, and have a completion closure as well. The completion closure should use @escaping.
    func createMessageThread(with title: String, completion: @escaping (Error?) -> Void) {
       // Inside the function, initialize a new MessageThread object.
        let newMessageThread = MessageThread(title: title)
//   We need to create a URL using the thread's identifier property. This will let us put the thread at a unique location in the API. To do this, use the appendingPathComponent method on the baseURL property. (again, you will need to use the MessageThreadController class to access the baseURL.) Since we are using Firebase as the API, you must also append a "json" path extension (using appendingPathExtension) to the URL or the requests will not work at all. The full URL should look something like this: https://lambda-message-board.firebaseio.com/695398C4-498C-40A8-AA76-CB2B20DFD9FA/.json. Note that it doesn't matter if the last / is in the URL or not
        let url = MessageThreadController.baseURL.appendingPathComponent(newMessageThread.identifier)
        let newUrl = url.appendingPathExtension("json")
        
      //  Create a URLRequest variable with the URL you just created. Set its httpMethod to "PUT".
        var urlRequest = URLRequest(url: newUrl)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        
        //Encode the MessageThread object you just initialized using JSONEncoder in a do-try-catch block.
        
        do {
            let jsonEncoder = JSONEncoder()
           let messageThread =  try jsonEncoder.encode(newMessageThread)
            urlRequest.httpBody = messageThread
        } catch {
            NSLog("Error encoding new message thread \(newMessageThread)")
            completion(error)
            return
        }
        
//        Perform a URLSessionDataTask with the URLRequest you just created. Handle the potential error returned in the completion closure. If there was no error, then append the MessageThread object to the messageThreads variable. Remember to call completion, and resume the data task.
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if error != nil {
                NSLog("Error completing data Task \(error!)")
                completion(error)
                return
            }
            
            self.messageThreads.append(newMessageThread)
            completion(nil)
            
        }.resume()
    }
    
//    You now need a method to create messages within a MessageThread. In order to do that:
//
//    Create a function called createMessage. It should take in a MessageThread parameter (so you can put the new message in the correct thread), text and sender string parameters, and an escaping completion closure.
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        //Inside of the function, initialize a MessageThread.Message object from the parameters in this function.
        let newMessageThread = MessageThread.Message(text: text, sender: sender)
        
        
//        Create a URL just like you did in the previous function by using the baseURL and the MessageThread parameter's identifier. This time, also append another path component called "messages". NOTE: Because of the way Codable works by default, this string should match the name of the MessageThread's array of messages property or you will run into trouble later on. After you've appended the identifier and "messages" to the URL, append the "json" path extension. This path extension must be at the end of the URL.
        
       let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        let newUrl = url.appendingPathComponent("messages")
        let urlWithPathExtension = newUrl.appendingPathExtension("json")
        
//        Create a URLRequest variable with the URL you just created. Set its httpMethod to "POST".
        
        var request = URLRequest(url: urlWithPathExtension)
        request.httpMethod = HTTPMethod.post.rawValue
        
//        Encode the MessageThread.Message object you just initialized using JSONEncoder in a do-try-catch block.
        
        do {
            let jsonEncoder = JSONEncoder()
            let newMessage = try jsonEncoder.encode(newMessageThread)
            request.httpBody = newMessage
        } catch {
            NSLog("Error encoding new message: \(newMessageThread)")
        }
        
//        Perform a URLSessionDataTask with the URLRequest you just created. Handle the potential error returned in the completion closure. If there was no error, then append the MessageThread.Message object to the MessageThread.Message variable. Since the MessageThread is a class, you can directly append it to its array of messages here. Remember to call completion, and resume the data task.
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if error != nil {
                NSLog("Error completing data task \(error)")
                completion(error)
                return
            }
            messageThread.messages.append(newMessageThread)
            completion(nil)
        }.resume()
        
    }
}
