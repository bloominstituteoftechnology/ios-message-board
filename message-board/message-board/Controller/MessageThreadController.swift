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
		url.appendPathComponent(messageThread.identifier)
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
		url.appendPathComponent(messageThread.identifier)
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
		url.appendPathExtension("json")

		var urlrequest = URLRequest(url: url)
		urlrequest.httpMethod = PushMethod.get.rawValue
		
		print(urlrequest)
		
		URLSession.shared.dataTask(with: urlrequest) { (data, _, error) in
			if let error = error {
				print("error: fetchMessageThreads \(error)")
			}
			
			guard let data = data else { return }
			let decode = JSONDecoder()
			
			do{
				let messageThreadDictionaries = try decode.decode([String: MessageThread].self, from: data)
				print(messageThreadDictionaries.count)
//				let messageThreads = Array(messageThreadDictionaries)
//				self.messageThreads = messageThreads
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
