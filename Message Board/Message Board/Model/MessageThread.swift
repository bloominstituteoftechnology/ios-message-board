//
//  MessageThread.swift
//  Message Board
//
//  Created by Hayden Hastings on 5/15/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import Foundation

class MessageThread: Equatable ,Codable {
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.messages == rhs.messages && rhs.title == lhs.title && lhs.identifier == rhs.identifier
    }
    
    struct Message: Equatable, Codable {
        
        let text: String
        let sender: String
        let timeStamp: Date
        
        init(text: String, sender: String, timeStamp: Date) {
            self.text = text
            self.sender = sender
            self.timeStamp = timeStamp
        }
    }
}
