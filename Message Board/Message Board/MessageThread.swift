//
//  MessageThread.swift
//  Message Board
//
//  Created by Ryan Murphy on 5/15/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    var title: String
    var identifier: String
    var messages: [MessageThread.Message] = []
    struct Message: Codable, Equatable {
        var text: String
        var sender: String
        var timestamp: Date
        
        init(text: String, sender: String, timestamp: Date) {
            self.text = text
            self.sender = sender
            self.timestamp = Date()
        }
    }
    
    init(title: String, identifier: String = UUID().uuidString) {
        self.title = title
        self.identifier = identifier
        self.messages = []
    }
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        
       return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
}
