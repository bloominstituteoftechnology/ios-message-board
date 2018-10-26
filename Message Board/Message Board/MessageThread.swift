import UIKit

class MessageThread: Codable, Equatable {
    
    var messages: [MessageThread.Message]
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
               lhs.identifier == rhs.identifier &&
               lhs.messages == rhs.messages
    }
    
    let title: String
    let identifier: String
    
    init(title: String, messages: [MessageThread.Message] = []) {
        self.title = title
        self.messages = messages
        self.identifier = UUID().uuidString
    }
    
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
    
    //    Comment 1: The container is a KeyedDecodingContainer object. This object allows us to access the key-value pairs of the JSON in the decoder. We give it the CodingKeys enum of our MessageThread object so it knows which key-value pairs we want in the JSON. Notice that you never implemented a CodingKeys enum in this class. If you don't Codable will synthesize one for you based on the names of the class or struct's properties.
    //    Comment 2: Using the container object, we pull out the individual values from each key-value pair. We specify the type we expect the value to be such as String.self or in the case of messageDictionaries, it is [String: MessageThread.Message]. We also use the CodingKeys cases to specify which key-value pair to pull the value from in the JSON.
    //    Comment 3: As stated previously, since you are POSTing the messages, the API will create a unique identifier as the key, and use the MessageThread.Message as the value. This is the part that would break the decoding if we didn't implement this initializer. In order to circumvent this problem, we take each MessageThread.Message object and sort of discard the identifier key by mapping through the dictionaries and returning only the value, which is the actual message object. We use the deciodeIfPresent method because if the MessageThread doesn't have any messages in it (i.e. right when the message thread is created), it will throw an error if we use decode. decodeIfPresent will try to decode it, but if there is no value, it will simply return nil instead.
    //    Comment 4: We then set the classes properties to the newly decoded properties, similar to a normal memberwise initializer.
}
