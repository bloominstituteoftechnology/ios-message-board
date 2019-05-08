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
}

class MessageThreadController {
	
	func CreateMessageThread (title: String, completion: @escaping (Error?) -> Void) {
		let messageThread = MessageThread(title: title)
		
		var url = MessageThreadController.baseURL
		if let id = messageThread.idnetifier {
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
				print(error)
				return
			} else {
				self.messageThreads.append(messageThread)
				completion(nil)
			}
			
		}.resume()
	}
	
	func createMessage(messageThread: MessageThread, text: String, sender: String, completion: (Error?) -> Void ) {
		let message = MessageThread.Message(text: text, sender: sender)
		var url = MessageThreadController.baseURL
		
		if let id = messageThread.idnetifier {
			url.appendPathComponent(id)
		}
		
		url.appendPathComponent("messages")
		url.appendPathExtension("json")
		
		var request = URLRequest(url: url)
		request.httpMethod = PushMethod.post.rawValue
		print(request)
		
		
		
		
	}
	
	static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
	var messageThreads: [MessageThread] = []
}
