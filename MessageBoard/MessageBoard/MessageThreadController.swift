import Foundation

class MessageThreadController {
    var messageThreads: [MessageThread] = []
    
    static let baseURL: URL! = URL(string: "https://lambda-chat-project.firebaseio.com/")
    
    func createMessageThread(title: String, completion: @escaping (_ success: Bool) -> Void = { _ in }) {
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
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Fail on error
            if let error = error {
                NSLog("Error: \(error)")
                completion(false)
                return
            }
            
            self.messageThreads.append(messageThread)
            completion(true)
        }
        dataTask.resume()
    }
    
    
}
