//
//  MessageThread.swift
//  Message Board
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    // MARK: - Properties
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    
    // MARK: - Message struct
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String) {
            self.text = text
            self.sender = sender
            self.timestamp = Date()
        }
    }
    
    
    // MARK: - Initializers
    
    init(title: String) {
        self.title = title
        self.identifier = UUID().uuidString
        self.messages = []
    }
    
    
    // MARK: This code has taken from the instruction
    
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
    
    
    // MARK: - Equatable protocol
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
}
