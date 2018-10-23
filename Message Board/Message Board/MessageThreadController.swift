import UIKit

class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThreads = MessageThread(title: title)
        
        var requestURL = MessageThreadController.baseURL.appendingPathComponent(messageThreads.identifier)
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
    
        }
    }
}
