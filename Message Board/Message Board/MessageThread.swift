//
//  MessageThread.swift
//  Message Board
//
//  Created by Moin Uddin on 9/12/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation


class MessageThread: Codable, Equatable {
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title
    }
    
    let title: String
    let identifier: String
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timestamp: Date = Date()
        init(text: String, sender: String) {
            self.text = text
            self.sender = sender
        }
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
    
    var messages: [MessageThread.Message] = []
    
}
