//
//  MessageThreadController.swift
//  iOSMessageBoard
//
//  Created by Jonathan Ferrer on 5/15/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class MessageThreadController {

    var messageThreads: [MessageThread] = []
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!


    func fetchMessageThread(completion: @escaping (Error?) -> Void) {
        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")
        let request = URLRequest(url: requestURL)

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Errors pulling data from Firebase: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned")
                completion(NSError())
                return
            }

            let decoder = JSONDecoder()

            do{
                let messageThreadDictionaries = try decoder.decode([String: MessageThread].self, from: data)

                let messageThreads = messageThreadDictionaries.map( { $0.value })
                self.messageThreads = messageThreads
            } catch {
                NSLog("Error decoding messageThreads: \(error)")
                completion(error)

            }
        }



    }

    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping () -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        let identifierURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        var requestURL = identifierURL.appendingPathComponent("messages")
        requestURL.appendPathComponent("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue

        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(message)
            completion()
        } catch {
            NSLog("Errors encoding messages to FireBase\(error)")
            completion()
            return
        }

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error pushing message to Firebase: \(error)")
                completion()
                return
            }
            messageThread.messages.append(message)
            completion()
        }.resume()

    }


    func createMessagethread(title: String, completion: @escaping () -> Void) {

        let messageThread = MessageThread(title: title)
        let identifierURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        let requestURL = identifierURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)

        request.httpMethod = HTTPMethod.put.rawValue

        do {
            let jsonEncoder = JSONEncoder()
            request.httpBody = try jsonEncoder.encode(messageThread)
        } catch {
            NSLog("Error encoding messageThread: \(error)")
            completion()
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                NSLog("Error pushing messageThread to Firebase: \(error)")
                completion()
                return
            }
            self.messageThreads.append(messageThread)
            completion()
        }.resume()
    }



}
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

