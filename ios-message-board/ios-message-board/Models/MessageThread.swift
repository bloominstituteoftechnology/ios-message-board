//
//  MessageThread.swift
//  ios-message-board
//
//  Created by De MicheliStefano on 08.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
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
            self.sender = sender
            self.timestamp = timestamp
        }
        
    }
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = [] ) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
    
}

