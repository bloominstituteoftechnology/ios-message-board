//
//  MessageThread.swift
//  Message Board
//
//  Created by Linh Bouniol on 8/8/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
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
    
    init(title: String, identifier: UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
}
