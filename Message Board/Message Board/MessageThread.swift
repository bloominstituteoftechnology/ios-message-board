//
//  MessageThread.swift
//  Message Board
//
//  Created by Nathanael Youngren on 1/23/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
    let title: String
    let indentifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, indentifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.indentifier = indentifier
        self.messages = messages
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
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.indentifier == rhs.indentifier &&
            rhs.indentifier == lhs.indentifier
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .indentifier)
        let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)

        let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []

        self.title = title
        self.indentifier = identifier
        self.messages = messages
    }
}
