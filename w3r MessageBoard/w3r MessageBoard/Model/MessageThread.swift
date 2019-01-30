//
//  MessageThread.swift
//  w3r MessageBoard
//
//  Created by Michael Flowers on 1/30/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    var title: String
    var identifier: String
    var messages: [MessageThread.Message] //Remember you have to go through this thread in order to get to the message struct and its properties
    //we need to create a separate model object for the messages within the thread. This goes back to the concept of making a model object for EACH LAYER of the JSON. You may notice that the value for the "messages" key in the JSON is another dictionary.
    
    //create an init and give a default value  of an empty array to the messages property and ad a value of uuid to ident.
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
    
    struct Message: Codable, Equatable { //because this is nested inside of the messageThread class, you must use MessageThread.Message to acces its properties
        var text: String
        var sender: String
        var timestamp: Date
        
        //create an initializer to give timestamp a default value when one is initialized
        init(text: String, sender: String, timestamp: Date = Date()){
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
        
    }
}


