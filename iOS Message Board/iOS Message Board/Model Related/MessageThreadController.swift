import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://message-board-3e056.firebaseio.com/")!
    // NOTE: In order to access this `baseURL`, you must call the class `MessageThreadController`, then `.baseURL` because this is a static property.
    // e.g.: MessageThreadController.baseURL
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        // Inside the function, initialize a new `MessageThread` object.
        // Since we're passing only title as our only argument, that is what will be used in the initializer.
        let messageThread = MessageThread(title: title)
        
        let threadIdentifierURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        
        let url = threadIdentifierURL.appendingPathExtension("json")
        
        // requestURL is used to avoid annoyances with autocomplete
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            requestURL.httpBody = try encoder.encode(messageThread)
            
        } catch {
            print(error)
            completion(error)
            return
        }
        
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
        
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            self.messageThreads.append(messageThread)
            
            completion(nil)
            
        }.resume()
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, sender: String, completion: @escaping (Error?) -> Void) {
        
        let messageComponents = MessageThread.Message(text: text, sender: sender)
        
        let threadMessageURL = MessageThreadController.baseURL.appendingPathComponent(messageThread.identifier)
        
        let messageURL = threadMessageURL.appendingPathComponent("messages")
        
        let url = messageURL.appendingPathExtension("json")
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            requestURL.httpBody = try encoder.encode(messageComponents)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (_, _, error) in
            
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            messageThread.messages.append(messageComponents)
            
            completion(nil)
            
        }.resume()
        
    }
    
    func fetchMessageThreads(completion: @escaping (Error?) -> Void) {
        let url = MessageThreadController.baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                
                let messageThreadDictionaries = try decoder.decode([String: MessageThread].self, from: data)
                let messageThreads = messageThreadDictionaries.map({ $0.value })
                self.messageThreads = messageThreads
                completion(nil)
            
            } catch {
                
                print(error)
                completion(error)
                return
                
            }
            
        }.resume()
        
    }
}
