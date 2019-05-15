//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Kobe McKee on 5/15/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    

    required init(from decoder: Decoder) throws {
        //container is a KeyedDecodingContainer
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //using container, pull the values for these keys
        
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)
        //returns only the messages, not the identifiers or everything would break
        
        let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []
        
        self.title = title
        self.identifier = identifier
        self.messages = messages
  
    }
    
    
    
    
    let title: String
    let identifier: String
    
    var messages: [Message]
    
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
    
    
    init(title: String, identifier: String = UUID().uuidString, messages: [Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    
    
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
    
    
}
