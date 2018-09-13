//
//  MessageThread.swift
//  Message Board
//
//  Created by Jason Modisett on 9/12/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    init(title: String) {
        self.title = title
        self.messages = []
        self.identifier = UUID().uuidString
    }
    
    let title: String
    let identifier: String
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timestamp: Date
        
        static func ==(lhs: Message, rhs: Message) -> Bool {
            return lhs.text == rhs.text &&
                lhs.sender == rhs.sender &&
                lhs.timestamp == rhs.timestamp
        }
        
        init(text: String, sender: String) {
            self.text = text
            self.sender = sender
            self.timestamp = Date()
        }
    }
    
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            rhs.identifier == lhs.identifier &&
            rhs.messages == lhs.messages
    }
    
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
    
    var messages: [MessageThread.Message]
}
