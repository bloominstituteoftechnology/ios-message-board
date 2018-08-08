//
//  MessageThread.swift
//  Message Board
//
//  Created by Jeremy Taylor on 8/8/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String, messages: [MessageThread.Message]) {
        self.title = title
        self.identifier = UUID().uuidString
        self.messages = []
    }
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String) {
            self.text = text
            self.sender = sender
            timestamp = Date()
        }
    }
    func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.identifier == rhs.identifier &&
            rhs.messages == lhs.messages &&
            rhs.title == lhs.title
    }
}
