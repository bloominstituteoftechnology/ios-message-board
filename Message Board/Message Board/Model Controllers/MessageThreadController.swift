//
//  MessageThreadController.swift
//  Message Board
//
//  Created by Michael Redig on 5/8/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class MessageThreadController {

	var messageThreads: [MessageThread] = []

	static let baseURL = URL(string: "https://lambda-school-mredig.firebaseio.com/")!

	func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
		let messageThread = MessageThread(title: title)

		var url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
		url = url.appendingPathExtension("json")

		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethods.put.rawValue

		let encoder = JSONEncoder()
		do {
			request.httpBody = try encoder.encode(messageThread)
		} catch {
			print("error encoding data: \(error)")
			completion(error)
		}

		URLSession.shared.dataTask(with: request) { (_, response, error) in
			if let error = error {
				print("error getting url '\(request.url ?? URL(string: "")!)': \(error)")
				completion(error)
				return
			} else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
				print("non 200 http response: \(response.statusCode)")
				completion(HTTPError.non200StatusCode)
				return
			}
			completion(nil)
		}.resume()
	}
}
