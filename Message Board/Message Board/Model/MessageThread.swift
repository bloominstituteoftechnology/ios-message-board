//
//  MessageThread.swift
//  Message Board
//
//  Created by Madison Waters on 9/19/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

class MessageThread: Codable{
    
    let title: String
    let identifier: String
    
    var messages: [MessageThread.Message] = []
    
    init(title: String, identifier: String, messages: [MessageThread.Message]) {
        self.title = title
        self.identifier = UUID().uuidString
        self.messages = []
    }
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timeStamp: Date
        
        init(text: String, sender: String, timeStamp: Date) {
            self.text = text
            self.sender = sender
            self.timeStamp = Date()
            
        }
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
}
