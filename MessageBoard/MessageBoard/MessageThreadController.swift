import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    static let baseURL: URL! = URL(string: "https://message-board-2a09c.firebaseio.com/")
    typealias RequestClosure = (_ success: Bool) -> Void
    
    func createMessageThread(title: String, completion: @escaping RequestClosure) {
        let messageThread = MessageThread(title: title)
        let url = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier).appendingPathExtension("json")
        
        // Fetch appropriate request URL customized to method
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(messageThread)
        } catch {
            fatalError("Error encoding message thread: \(messageThread) \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Fail on error
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(true)
        }
        .resume()
    }
    
    func createMessage(thread: MessageThread, text: String, sender: String, completion: @escaping RequestClosure) {
        let newMessage = MessageThread.Message(text: text, sender: sender)
        let url = MessageThreadController.baseURL.appendingPathComponent(thread.identifier).appendingPathComponent("messages").appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        do {
            request.httpBody = try JSONEncoder().encode(newMessage)
        } catch {
            fatalError("Error encoding message thread: \(newMessage) \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            thread.messages.append(newMessage)
            completion(true)
        } .resume()
    }
    
    func fetchMessageThreads(completion: @escaping RequestClosure) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            guard let data = data else {
                NSLog("Data was not recieved.")
                completion(false)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let messageThreadDictionaries = try jsonDecoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ $0.value })
                self.messageThreads = messageThreads
                completion(true)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(false)
                return
            }
           
            }.resume()
    }
    
}
