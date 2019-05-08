//
//  MessageThreadController.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class MessageThreadController {
	
	func CreateMessageThread (title: String, completion: @escaping (Error?) -> Void) {
		var thread = MessageThread(title: title)
		
		var url = MessageThreadController.baseURL
		if let id = thread.idnetifier {
			url.appendPathComponent(id)
		}
		
		url.appendPathExtension("json")
		
		var  request = URLRequest(url: url)
		print(request)
		
		do {
			let encoder = JSONEncoder()
			request.httpBody = try encoder.encode(thread)
			completion(nil)
		} catch {
			completion(error)
		}
		
	}
	
	
	
	static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
	var messageThreads: [MessageThread] = []
}
