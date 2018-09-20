//
//  MessageThread.swift
//  Message Board
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    // MARK: - Properties
    
    let title: String
    let identifier: String
    var messages: [MessageThread.Message]
    
    // MARK: - Message struct
    
    struct Message: Equatable, Codable {
        let text: String
        let sender: String
        let timestamp: Data
        
        init(text: String, sender: String) {
            self.text = text
            self.sender = sender
            self.timestamp = Data()
        }
    }
    
    // MARK: - Initializer
    
    init(title: String) {
        self.title = title
        self.identifier = UUID().uuidString
        self.messages = [MessageThread.Message]()
    }
    
    // MARK: - Equatable protocol
    
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
