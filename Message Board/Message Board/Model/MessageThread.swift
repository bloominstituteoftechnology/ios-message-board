//
//  MessageThread.swift
//  Message Board
//
//  Created by Welinkton on 9/20/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text:String, sender:String){
            self.text = text
            self.sender = sender
            self.timestamp = Date()
        }
    }
    
    init(title: String){
        self.title = title
        self.messages = []
        self.identifier = UUID().uuidString
        
    }
}
