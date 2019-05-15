//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Kobe McKee on 5/15/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    
    
    let title: String
    let identifier: String
    
    var messages: [Message]
    
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
    
    
    init(title: String, identifier: String = UUID().uuidString, messages: [Message] = []) {
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
