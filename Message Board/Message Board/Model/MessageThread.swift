//
//  MessageThread.swift
//  Message Board
//
//  Created by Dillon McElhinney on 9/12/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    // MARK: - Properties
    let title: String
    let identifier: String
    
    var messages: [Message]
    
    // MARK: - Equatable
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    // MARK: - Initializers
    init(title: String) {
        self.title = title
        self.identifier = UUID().uuidString
        self.messages = []
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

}

extension MessageThread {
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String) {
            self.text = text
            self.sender = sender
            self.timestamp = Date()
        }
    }
}
