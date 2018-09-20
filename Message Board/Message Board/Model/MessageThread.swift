//
//  MessageThread.swift
//  Message Board
//
//  Created by Welinkton on 9/20/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class MessageThread: Codable {
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    struct Message {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text:String, sender:String, timestamp:Date = Date()){
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
    
    init(title: String, identifier: String = UUID().uuidString , messages: []){
        self.title = title
        self.identifier = identifier
        self.messages = messages
        
    }
}
