//
//  MessageThread.swift
//  Message Board
//
//  Created by Moses Robinson on 1/23/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {

    let title: String
    let identifier: String
    var messages: [Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [Message] = []) {
        (self.title, self.identifier, self.messages) = (title, identifier, messages)
    }
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            (self.text, self.sender, self.timestamp) = (text, sender, timestamp)
        }
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
}
