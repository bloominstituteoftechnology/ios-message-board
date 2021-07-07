//
//  MessageThread.swift
//  Message Board
//
//  Created by Scott Bennett on 9/19/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {

    // Function to make MessageThread Equatable
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
    
    let title: String
    let identifier: String
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
    
    var messages: [MessageThread.Message]
    
    init(messages: [MessageThread.Message] = [], title: String, identifier: String = UUID().uuidString) {
        self.messages = messages
        self.title = title
        self.identifier = identifier
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
