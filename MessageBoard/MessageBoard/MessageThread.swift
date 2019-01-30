//
//  MessageThread.swift
//  MessageBoard
//
//  Created by Paul Yi on 1/30/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class MessageThread: Codable {
    let title: String
    let identifier: String
    
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
}
