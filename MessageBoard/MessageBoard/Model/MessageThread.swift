//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Paul Yi on 1/30/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class MessageThread: Codable {
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    // Adopt the Equatable protocol
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timeStamp: Date
        
        init(text: String, sender: String, timeStamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timeStamp = timeStamp
        }
    }
}
