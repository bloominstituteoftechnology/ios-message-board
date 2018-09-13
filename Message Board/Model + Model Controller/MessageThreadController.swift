//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Jason Modisett on 9/12/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class MessageThreadController {
    
    func createMessageThread(with title: String, completion: @escaping (Error?) -> (Void)) {
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL?.appendingPathComponent(messageThread.identifier).appendingPathComponent("json")
        print(url?.absoluteString)
    }
    
    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")
}
