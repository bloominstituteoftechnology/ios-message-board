//
//  MessageThread.swift
//  ios-message-board
//
//  Created by Austin Cole on 12/13/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import Foundation

class MessageThread: Codable /*Equatable*/ {
//    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
//        
//    }
    
    
    
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    struct Message: Codable {
        let text: String
        let sender: String
        let timeStamp: Date
        
        init(text: String, sender: String,timeStamp:Date = Date()) {
            self.sender = sender
            self.text = text
            self.timeStamp = timeStamp
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
    
    
    
}
