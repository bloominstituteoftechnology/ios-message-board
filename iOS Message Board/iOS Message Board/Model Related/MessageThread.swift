//
//  MessageThread.swift
//  iOS Message Board
//
//  Created by Jaspal on 1/23/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    
    let title: String
    let identifier: String
    
    // Not sure if struct or class would be better here.
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timeStamp: Date
        
        // Initializer in class: Simple
        // Initializer in project: one more thing...
        init(text: String, sender: String, timeStamp: Date = Date()) {
            self.text = text
            self.sender = sender
            self.timeStamp = timeStamp
        }
    }
    
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    // Make sure both sides are equal to each other.
    // The identifier is what matters most here, since we need to retrieve
    // the correct item's content and we're not using SHA or GPG verification.
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return rhs.identifier == lhs.identifier &&
            lhs.identifier == rhs.identifier
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

