//
//  MessageBoard.swift
//  MessageBoard
//
//  Created by William Bundy on 8/8/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation

// The built in error types are more complicated than
// I'd like... this'll be fine
typealias ErrorString = String
typealias CompletionHandler = (ErrorString?)->Void

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

	init(_ title:String = "")
	{
		self.title = title
	}

	required init(from decoder:Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		title = try container.decode(String.self, forKey:.title)
		identifier = try container.decode(String.self, forKey:.identifier)

		let dict = try container.decodeIfPresent([String:Message].self, forKey:.messages)
		self.messages = dict?.compactMap({$0.value}) ?? []
	}

	static func ==(l:MessageTopic, r:MessageTopic) -> Bool
	{
		return l.identifier == r.identifier
	}
}

enum App {
	static let baseURL = URL(string:"https://lambda-message-board.firebaseio.com/")!
	static var controller = MessageController()
}

class MessageController
{
	var topics:[MessageTopic] = []

	func buildRequest(_ ids:[String], _ httpMethod:String, _ data:Data?=nil) -> URLRequest
	{
		var url = App.baseURL
		for id in ids {
			url.appendPathComponent(id)
		}
		url.appendPathExtension("json")
		var req = URLRequest(url: url)
		req.httpMethod = httpMethod
		req.httpBody = data
		return req
	}

	func pushMessage(_ msg:Message, topic:MessageTopic, _ completion: @escaping CompletionHandler)
	{
		topic.messages.append(msg)
		pushTopic(topic, completion)
	}

	func pushTopic(_ topic:MessageTopic, _ completion: @escaping CompletionHandler)
	{
		var data:Data?
		do {
			let enc = JSONEncoder()
			data = try enc.encode(topic)
		} catch {
			completion("Failed to encode topic")
		}
		let req = buildRequest([topic.identifier], "PUT", data)
		URLSession.shared.dataTask(with: req) { (data, _, error) in
			if let error = error {
				NSLog("Error uploading topic: \(error)")
				completion("Error putting topic")
				return
			}
			completion(nil)
		}.resume()
	}

	func fetchTopics(_ completion:@escaping CompletionHandler)
	{
		let req = buildRequest([], "GET")
		URLSession.shared.dataTask(with: req) { data, _, error in
			if let error = error {
				NSLog("Error fetching data: \(error)")
				completion("Error fetching data")
				return
			}

			guard let data = data else {
				NSLog("Fetching data: Data was nil!")
				completion("Error fetching: data was nil")
				return
			}

			do {
				let dec = JSONDecoder()
				let msg = try dec.decode([String:MessageTopic].self, from: data)
				self.topics = Array(msg.values)
				completion(nil)
				return
			} catch {
				NSLog("Fetching: Failed to decode data!")
				completion("Error fetching: couldn't decoding data")
				return
			}
		}.resume()
	}
}

