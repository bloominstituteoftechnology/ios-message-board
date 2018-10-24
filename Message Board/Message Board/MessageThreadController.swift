import UIKit

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThreads)
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
        let message = MessageThread.Message(text: text, sender: sender, timestamp: Date())
        
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
            
            self.messageThreads.append(thread)
            completion(nil)
        }
        
        dataTask.resume()
    }
    
}
