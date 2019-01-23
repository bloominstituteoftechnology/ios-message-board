//
//  MessageThread.swift
//  MessageBoard Project
//
//  Created by Michael Flowers on 1/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    //The reason for making this a class is....
    
    var title: String
    var identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
    
    
    //We need to create a separate model object for the messages within the thread. This goes back to the concept of making a model object for each "layer" of the JSON.You may notice that the value for the "messages" key in the JSON is another dictionary, inside the MessageThread class, create a struct called Message
    struct Message: Codable, Equatable {
        
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
        
        static func == (lhs: MessageThread.Message, rhs: MessageThread.Message) -> Bool {
            return lhs.timestamp == rhs.timestamp && lhs.sender == rhs.sender && lhs.text == rhs.text
        }
    }
    
    
}
