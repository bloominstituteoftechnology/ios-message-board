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
    
    init(title: String, indentifier: String = UUID().uuidString, messages: [MessageThread.Message] = []) {
        self.title = title
        self.indentifier = indentifier
        self.messages = messages
    }
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.indentifier == rhs.indentifier &&
            lhs.messages == rhs.messages
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
    
//    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
//
//        let newMessage = MessageThread.Message(text: text, sender: sender)
//
//        let messageThreadURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.indentifier)
//
//        let messagesURL = messageThreadURL.appendingPathComponent("messages")
//
//        let jsonURL = messagesURL.appendingPathExtension("json")
//
//        var requestURL = URLRequest(url: jsonURL)
//        requestURL.httpMethod = "POST"
//
//        let jsonEncoder = JSONEncoder()
//
//        do {
//            requestURL.httpBody = try jsonEncoder.encode(newMessage)
//        } catch {
//            print(NSError())
//            completion(error)
//            return
//        }
//
//        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
//            if let error = error {
//                print(error)
//                completion(error)
//                return
//            }
//            self.messages.append(newMessage)
//            completion(nil)
//        }.resume()
//    }
}
