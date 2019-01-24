//    Copyright © 2019 Frulwinn. All rights reserved.

import Foundation


class MessageThread: Equatable, Codable {
    
    var messages: [MessageThread.Message] = []
    
    var title: String
    var identifier: String
    
    init(title: String, identifier: String = UUID().uuidString) {
        self.title = title
        self.identifier = identifier
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.messages == rhs.messages &&
        lhs.title == rhs.title &&
        lhs.identifier == rhs.identifier
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
