//
//  MessageThread.swift
//  Message Board
//
//  Created by Michael Redig on 5/8/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class MessageThread: Equatable, Codable {
	let title: String
	let identifier: String

	var messages = [Message]()

	init(title: String, identifier: String = UUID().uuidString) {
		self.messages = []
		self.identifier = identifier
		self.title = title
	}

	struct Message: Equatable, Codable {
		let text: String
		let sender: String
		let timestamp = Date()
	}

	static func == (rhs: MessageThread, lhs: MessageThread) -> Bool {
		return rhs.identifier == lhs.identifier
	}
}
