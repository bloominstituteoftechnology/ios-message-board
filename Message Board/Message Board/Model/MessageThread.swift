//
//  MessageThread.swift
//  Message Board
//
//  Created by Dillon McElhinney on 9/12/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
    
    // MARK: - Properties
    let title: String
    let identifier: String
    
    var messages: [MessageThread.Message]
    
    // MARK: - Equatable
    static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    struct Message: Codable, Equatable {
        let text: String
        let sender: String
        let timeStamp: Date
        
        init(text: String, sender: String) {
            self.text = text
            self.sender = sender
            self.timeStamp = Date()
        }
    }
    
    // MARK: - Initializers
    init(title: String) {
        self.title = title
        self.identifier = UUID().uuidString
        self.messages = []
    }
    
}
