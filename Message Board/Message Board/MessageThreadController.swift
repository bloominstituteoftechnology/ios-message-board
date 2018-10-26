import UIKit

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://moses-lambda-message-board.firebaseio.com/")!
    
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        let requestURL = MessageThreadController.baseURL
            .appendingPathComponent(messageThread.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
            
        } catch {
            NSLog("Unable to encode messageThread: \(error)")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _ , error in
            
            if let error = error {
                NSLog("Server POST error: \(error)")
                completion(error)
                return
            }
            self.messageThreads.append(messageThread)
            completion(nil)
        }
        dataTask.resume()
    }
    
    
    
    func createMessage(thread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        let message = MessageThread.Message(text: text, sender: sender)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(thread.identifier).appendingPathComponent("message")
        
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Unable to encode messageThread: \(error)")
            completion(error)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _ , error in
            
            if let error = error {
                NSLog("Server POST error: \(error)")
                completion(error)
                return
            }
            thread.messages.append(message)
            completion(error)
        }
        dataTask.resume()
    }
    
    
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void ) {
        
        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, _, error in
            
            if let error = error {
                NSLog("\(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data from data task")
                completion(NSError())
                return
            }
            
            do{
                let messageThreadsDictionaries = try JSONDecoder().decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadsDictionaries.map( {$0.value} )
                self.messageThreads = messageThreads
                completion(error)
            } catch {
                NSLog("Error encoding message: \(error)")
                completion(error)
                return
            }
        }
        dataTask.resume()
    }
}
