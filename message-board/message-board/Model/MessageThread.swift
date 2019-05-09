//
//  MessageThread.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class MessageThread: Codable, Equatable {
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let title = try container.decode(String.self, forKey: .title)
		let identifier = try container.decode(String.self, forKey: .identifier)
		let messagesDictionaries = try container.decodeIfPresent([String: Message].self, forKey: .messages)
		let messages = messagesDictionaries?.compactMap({ $0.value }) ?? []
		
		self.title = title
		self.identifier = identifier
		self.messages = messages
	}
	
	init(title: String, identifier: String = (UUID().uuidString) , messages: [Message] = []) {
		self.title = title
		self.identifier = identifier
		self.messages =  messages
	}
	
	struct Message: Codable, Equatable {
		let text: String
		let sender: String
		let timestamp: Date
		
		init(text: String, sender: String, timestamp: Date = (Date())) {
			self.text = text
			self.sender = sender
			self.timestamp = timestamp
		}
	}
	
	
	let title: String
	let identifier: String
	var messages: [MessageThread.Message]
	
	static func == (lhs: MessageThread, rhs: MessageThread) -> Bool {
		return  lhs.identifier == rhs.identifier
	}
}
