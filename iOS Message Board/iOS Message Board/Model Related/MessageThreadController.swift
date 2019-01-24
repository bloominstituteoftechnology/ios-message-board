import Foundation

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    // Or use: https://message-board-3e056.firebaseio.com/
    static let baseURL = URL(string: "https://lambda-message-board.firebase.com/")!
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
    
}
