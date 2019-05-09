//
//  MessageThreadController.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

enum PushMethod: String {
	case post = "POST"
	case put = "PUT"
	case get = "GET"
}

class MessageThreadController {
	
	func CreateMessageThread (title: String, completion: @escaping (Error?) -> Void) {
		let messageThread = MessageThread(title: title)
		
		var url = MessageThreadController.baseURL
		if let id = messageThread.identifier {
			url.appendPathComponent(id)
		}
		
		url.appendPathExtension("json")
		
		var  request = URLRequest(url: url)
		request.httpMethod = PushMethod.put.rawValue
		
		print(request)
		
		do {
			let encoder = JSONEncoder()
			request.httpBody = try encoder.encode(messageThread)
		} catch {
			completion(error)
			print(error)
		}
		
		URLSession.shared.dataTask(with: request) { ( _, _, error) in
			
			if let error = error {
				completion(error)
				print("Error:createMessageThread dataTask ", error)
				return
			} else {
				self.messageThreads.append(messageThread)
				completion(nil)
			}
			
		}.resume()
	}
	
	func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void ) {
		let message = MessageThread.Message(text: text, sender: sender)
		var url = MessageThreadController.baseURL
		
		if let id = messageThread.identifier {
			url.appendPathComponent(id)
		}
		
		url.appendPathComponent("messages")
		url.appendPathExtension("json")
		
		var request = URLRequest(url: url)
		request.httpMethod = PushMethod.post.rawValue
		print(request)
		
		do {
			let encoder = JSONEncoder()
			request.httpBody = try encoder.encode(message)
		} catch {
			print(error)
			completion(error)
		}
		
		URLSession.shared.dataTask(with: request) { ( _, _, error) in
			
			if let error = error {
				print("Error:createMessage dataTask ", error)
				completion(error)
			}else {
				messageThread.messages.append(message)
				completion(nil)
			}
		}.resume()
	}
	
	func fetchMessageThreads(completion: @escaping (Error?) -> (Void)) {
		var url = MessageThreadController.baseURL
		
		var urlrequest = URLRequest(url: url)
		urlrequest.httpMethod = PushMethod.get.rawValue
		
		url.appendPathExtension("json")
		print(url)
		
		URLSession.shared.dataTask(with: urlrequest) { (data, _, error) in
			if let error = error {
				print("error: fetchMessageThreads \(error)")
			}
			
			guard let data = data else { return }
			
			do{
				let decode = JSONDecoder()
				let decodedDictionary = try decode.decode([String: MessageThread].self, from: data)
				let messageThreads = Array(decodedDictionary.values)
				self.messageThreads = messageThreads
				completion(nil)
			} catch {
				print("error: fetchMessageThreads:DataTask: \(error)")
				completion(error)
			}
			
		}.resume()
		
		
	}
	
	static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
	var messageThreads: [MessageThread] = []
}
