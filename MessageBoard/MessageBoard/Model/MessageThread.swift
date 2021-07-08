//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Farhan on 9/12/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        if lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages {
            return true
        } else {
            return false
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
    
    let title: String
    let identifier: String
    
    struct Message: Equatable, Codable {
        
        let text: String
        let sender: String
        var timestamp: Date = Date()
    }
    
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString ) {
        self.messages = []
        self.title = title
        self.identifier = identifier
    }
}
