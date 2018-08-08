//
//  MessageBoard.swift
//  MessageBoard
//
//  Created by William Bundy on 8/8/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation

struct Message: Codable, Comparable
{
	var text:String
	var sender:String
	var timestamp:Date

	init(_ text:String, _ sender:String, _ timestamp:Date = Date())
	{
		self.text = text
		self.sender = sender
		self.timestamp = timestamp
	}

	static func <(l:Message, r:Message) -> Bool
	{
		return l.timestamp < r.timestamp
	}
}

class MessageTopic: Codable, Equatable
{
	var title:String = ""
	var identifier:String = UUID().uuidString
	var messages:[Message] = []

	static func ==(l:MessageTopic, r:MessageTopic) -> Bool
	{
		return l.identifier == r.identifier
	}
}

class MessageController
{

}

