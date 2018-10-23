import UIKit

class MessageThread: Codable {
    
    var messages: [MessageThread.Message]
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
               lhs.identifier == rhs.identifier &&
               lhs.messages == rhs.messages
    }
    
    let title: String
    let identifier: String
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timestamp: Date
        
        init(text: String, sender: String, timestamp: Date) {
            self.text = text
            self.sender = sender
            self.timestamp = Date()
        }
    }
    
    init(title: String) {
        self.title = title
        self.messages = []
        self.identifier = UUID().uuidString
    }
}
