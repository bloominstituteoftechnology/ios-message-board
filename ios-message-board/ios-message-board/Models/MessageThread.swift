//
//  MessageThread.swift
//  ios-message-board
//
//  Created by Conner on 8/8/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)
        
        let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []
        
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    init(title: String, identifier: String = UUID().uuidString) {
        self.title = title
        self.identifier = identifier
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.title == rhs.title
    }
    
    let title: String
    let identifier: String
    
    var messages: [MessageThread.Message] = []
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timestamp = timestamp
        }
    }
}
