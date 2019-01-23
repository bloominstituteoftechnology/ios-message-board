//    Copyright © 2019 Frulwinn. All rights reserved.

import Foundation


class MessageThread: Equatable, Codable {
    
    var messages: [MessageThread.Message]
    
    let title: String
    let identifier: String
    
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
}
