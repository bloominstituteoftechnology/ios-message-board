//    Copyright © 2019 Frulwinn. All rights reserved.

import Foundation


class MessageThread: Codable {
    
    let title: String
    let identifier: String
    
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
