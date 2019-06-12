//
//  MessageThreadController.swift
//  Message Board - Put and Post
//
//  Created by Nathan Hedgeman on 6/11/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    var messages: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error) -> Void) {
        //The app data that will be sent
        let messageThread = MessageThread(title: title)
        
        //The base URL for the data that will be sent attaching it's UUID
        var threadURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        
        //Attaching .json on the end as required by this database
        threadURL.appendPathExtension("json")
        
        //Preparing the holder for the data and its URL (allowing the bundling of the data with the URL as ONE package
        var urlRequest = URLRequest(url: threadURL)
        
        //MARK: HTTP METHOD SET TO PUT/PUSH. Discribing WHAT this data will be doing @ it's URL (In this case "PUTTING")
        urlRequest.httpMethod = "PUT"
        
        do {
            //Encoding the data to so the database can understand it
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(messageThread)
            
        } catch {
            NSLog("\(error)")
            completion(error)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            guard let data = data else {
                completion(error)
                return
            }
        }.resume()
        
    
    }
}
