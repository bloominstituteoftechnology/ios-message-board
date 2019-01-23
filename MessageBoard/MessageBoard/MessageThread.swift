//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Jocelyn Stuart on 1/23/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && rhs.identifier == lhs.identifier && rhs.messages == lhs.messages
    }
   
    let title: String
    let identifier: String
    
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
}
