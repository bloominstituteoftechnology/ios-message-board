//
//  MessageThread.swift
//  Message Board
//
//  Created by Hayden Hastings on 5/15/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import Foundation

class MessageThread: Equatable ,Codable {
    
    let title: String
    let identifier: String
    var messages: [Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
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
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.messages == rhs.messages &&
            rhs.title == lhs.title &&
            lhs.identifier == rhs.identifier
    }
    
    struct Message: Equatable, Codable {
        
        let text: String
        let sender: String
        let timeStamp: Date
        
        init(text: String, sender: String, timeStamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timeStamp = timeStamp
        }
    }
}
