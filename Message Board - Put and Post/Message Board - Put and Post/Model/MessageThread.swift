//
//  MessageThread.swift
//  Message Board - Put and Post
//
//  Created by Nathan Hedgeman on 6/11/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    
    //Stub needed to conform to Equatable. (Why does the class need the stub but the Message struc doesnt?)
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
        lhs.identifier == rhs.identifier &&
        lhs.messages == rhs.messages
    }
    

    let title     : String
    let identifier: String
    var messages  : [MessageThread.Message]
    
    //Default identifier and messages values
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
        
    }
    
    //Nested Json dictionary
    struct Message: Equatable, Codable {
 
        let text     : String
        let sender   : String
        let timestamp: Date
        //Default date value as current date (hopefully)
        init(text: String, sender: String, date: Date = Date()) {
            
            self.text      = text
            self.sender    = sender
            self.timestamp = date
            
        }
    }
}
