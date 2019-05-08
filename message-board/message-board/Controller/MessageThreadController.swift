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
		var thread = MessageThread(title: title)
		
		var url = MessageThreadController.baseURL
		if let id = thread.idnetifier {
			url.appendPathComponent(id)
		}
		
		url.appendPathExtension("json")
		
		var  request = URLRequest(url: url)
		request.httpMethod = PushMethod.put.rawValue
		
		print(request)
		
		do {
			let encoder = JSONEncoder()
			request.httpBody = try encoder.encode(thread)
		} catch {
			completion(error)
		}
		
		URLSession.shared.dataTask(with: request) { ( _, _, error) in
			if let error = error {
				//create message
				let message = MessageThread.Message(text: error as! String, sender: "Sender is error")
				//append meesage
				thread.message.append(message)
				//append new thread to threads
				self.messageThreads.append(thread)
				completion(error)
				
				print(error)
				return
			}
			
			
			
		}.resume()
		
		
		
	}
	
	
	
	static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
	var messageThreads: [MessageThread] = []
}
