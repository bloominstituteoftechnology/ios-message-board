//
//  MessageThread.swift
//  Message Board
//
//  Created by Julian A. Fordyce on 1/23/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timestamp: Date

        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.timestamp = timestamp
            self.sender = sender
        }
        
    }
    
    
    init(title: String, messages: [MessageThread.Message] = [],  identifier: String = UUID().uuidString) {
        
        self.messages = messages
        self.title = title
        self.identifier = identifier
    }
    
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return rhs.title == lhs.title &&
         rhs.identifier == lhs.identifier &&
         rhs.messages == lhs.messages
    }
}
