//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Angel Buenrostro on 1/23/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable{
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.messages == rhs.messages &&
            lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier
    }
    
    
    var messages : [MessageThread.Message]
    
    let title : String
    let identifier : String
    
    
    init(messages : [MessageThread.Message] = [], title: String, identifier: String = UUID().uuidString) {
        self.messages = messages
        self.title = title
        self.identifier = identifier
    }
    
    struct Message: Codable, Equatable {
        let text : String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
    }
    
    
}
}
