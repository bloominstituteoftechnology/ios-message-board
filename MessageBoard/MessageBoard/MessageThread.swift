import Foundation

class MessageThread: Codable {
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    // Adopt the Equatable protocol in the MessageThread class by manually implementing the `==` function
    // All objects that conform to this protocol will now have default equality based on the protocol properties
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
    
    required init(from decoder: Decoder) throws {
        
        // 1 container is a KeyedDecodingContainer object
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2 Using the container object, pull out the individual values from each key-value pair.
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)
        
        // 3 Take each MessageThread.Message object and sort of discard the identifier key by mapping through the dictionaries and returning only the value, which is the actual messate object.
        let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []
        
        // 4 Set properties to newly decoded properties
        self.title = title
        self.identifier = identifier
        self.messages = messages
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
