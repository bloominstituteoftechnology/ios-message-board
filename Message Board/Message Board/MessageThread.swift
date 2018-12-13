import Foundation


class MessageThread: Codable, Equatable {
    
    var messages: [MessageThread.Message]
    let title: String
    let identifier: String
    
    init() {
        self.messages = []
        self.identifier = UUID().uuidString
        self.title = "" // not shure
    }
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Date
    }
    
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.title == rhs.title && lhs.messages == rhs.messages
}
}
