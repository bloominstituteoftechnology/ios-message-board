//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Nikita Thomas on 10/23/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.title == rhs.title && lhs.messages == rhs.messages
    }
    
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String) {
        self.title = title
        self.identifier = UUID().uuidString
        self.messages = []
    }
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timeStamp: Date
        
        init(text: String, sender: String) {
            self.timeStamp = Date()
            self.text = text
            self.sender = sender
        }
    }
    
}
