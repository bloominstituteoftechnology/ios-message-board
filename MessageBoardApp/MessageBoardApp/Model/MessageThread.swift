//
//  MessageThread.swift
//  MessageBoardApp
//
//  Created by Nelson Gonzalez on 1/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation


class MessageThread: Equatable, Codable {
    
//    Since the messages are being POSTed (thus creating a unique identifier key with the message as the value), we will run into an issue when trying to decode the fetched data from the API into MessageThread objects. In order to fix this, we are going to manually tell the decoder how to decode MessageThreads instead of letting Codable try to do it for us.
    
//    In the MessageThread class, add this initializer. Since we haven't covered this before now, we'll talk about each step marked with comments:
    
//    When this initializer is implemented, JSONDecoder (or any Decoder) will use the logic in this initializer to know how to parse the JSON and where to put the information in the MessageThread object that is being initialized.
    
    
    
    required init(from decoder: Decoder) throws {
        
        // 1 Comment 1: The container is a KeyedDecodingContainer object. This object allows us to access the key-value pairs of the JSON in the decoder. We give it the CodingKeys enum of our MessageThread object so it knows which key-value pairs we want in the JSON. Notice that you never implemented a CodingKeys enum in this class. If you don't Codable will synthesize one for you based on the names of the class or struct's properties.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 2 Comment 2: Using the container object, we pull out the individual values from each key-value pair. We specify the type we expect the value to be such as String.self or in the case of messageDictionaries, it is [String: MessageThread.Message]. We also use the CodingKeys cases to specify which key-value pair to pull the value from in the JSON.
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)
        
        // 3 Comment 3: As stated previously, since you are POSTing the messages, the API will create a unique identifier as the key, and use the MessageThread.Message as the value. This is the part that would break the decoding if we didn't implement this initializer. In order to circumvent this problem, we take each MessageThread.Message object and sort of discard the identifier key by mapping through the dictionaries and returning only the value, which is the actual message object. We use the deciodeIfPresent method because if the MessageThread doesn't have any messages in it (i.e. right when the message thread is created), it will throw an error if we use decode. decodeIfPresent will try to decode it, but if there is no value, it will simply return nil instead.
        let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []
        
        // 4 Comment 4: We then set the classes properties to the newly decoded properties, similar to a normal memberwise initializer.
        self.title = title
        self.identifier = identifier
        self.messages = messages
    }
    
    
    let title: String
    let identifier: String
    
    var messages: [MessageThread.Message]
    
    init(title: String, identifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
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
    
    //Why?
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.messages == rhs.messages
    }
}


