//  Copyright © 2019 Frulwinn. All rights reserved.

import Foundation

enum PushMethod: String {
    case post = "POST"
    case put = "PUT"
}

class MessageThreadController {
    //call MessageThreadController.baseURL
    static let baseURL = URL(string: "https://books-49747.firebaseio.com/")!
    
    
    var messageThreads: [MessageThread] = []
    
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
            //append the `MessageThread` object to the `messageThreads` variable
            self.messageThreads.append(messageThread)
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
            //append the `MessageThread.Message` object to the `MessageThread.Message` variable
            messageThread.messages.append(message)
            completion(nil)
            }.resume()
    }
    
    func fetchMessageThreads(completion: @escaping(Error?) -> Void) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let messageThreadDictionaries = try jsonDecoder.decode([String: MessageThread].self, from: data)
                //let messageThreads = Array(messageThreadDictionaries.values)
                let messageThreads = messageThreadDictionaries.map { $0.value }
                self.messageThreads = messageThreads
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
}
