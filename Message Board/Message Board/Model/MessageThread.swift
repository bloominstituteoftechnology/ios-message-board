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
    
    required init(from decoder: Decoder) throws {
        
        // 1
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)
        
        // 3
        let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []
        
        // 4
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    
    
    
}
