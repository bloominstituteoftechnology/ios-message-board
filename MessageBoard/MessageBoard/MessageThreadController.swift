//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

enum PushMethod: String {
    case post = "POST"
    case put = "PUT"
}

class MessageThreadController {
    //call MessageThreadController.baseURL
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!

    var messageThreads: [MessageThread] = []
    //var messages: [Message] = []
    
    func createMessageThread(withTitle title: String, completion: @escaping(Error?) -> Void) {
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        let newURL = url.appendingPathExtension("json")
        
        var request = URLRequest(url: newURL)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(messageThread)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error)  in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    
    }
        
        
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping(Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
       
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        var newUrl = url.appendingPathComponent("messages")
        
        newUrl.appendPathExtension("json")
        
        var request = URLRequest(url: newUrl)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(message)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error)  in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
}
