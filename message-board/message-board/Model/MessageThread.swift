//
//  MessageThread.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
	static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
		return  lhs.idnetifier == rhs.idnetifier 
	}
	
	let title: String?
	let idnetifier: String?
	var message: [MessageThread.Message]
	
	init(title: String, identifier: String = (UUID().uuidString) , message: [MessageThread.Message] = []) {
		self.title = title
		self.idnetifier = identifier
		self.message =  message
	}
	
	struct Message: Codable, Equatable {
		let text: String?
		let sender: String?
		let timestamp: Date?
		
		init(text: String, sender: String, timestamp: Date = (Date())) {
			self.text = text
			self.sender = sender
			self.timestamp = timestamp
		}
	}
}
