//
//  MessageThread.swift
//  Message Board
//
//  Created by Ivan Caldwell on 12/13/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    let title: String
    let identifier: String
    
    struct Message: Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String){
            self.text = text
            self.sender = sender
            self.timestamp = Date()
        }
    }
    
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String) {
            self.title = title
            self.identifier = UUID().uuidString
            self.messages = []
    }
    
    
    // I need to fix the inner Message thread...
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        if lhs.title != rhs.title {
            return false
        } else if lhs.identifier != rhs.identifier {
            return false
        }
        return true
    }
}
