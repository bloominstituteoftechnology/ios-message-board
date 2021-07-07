import Foundation


class MessageThreadController {
    
    var messageThreads: [MessageThread] = []
    
    static let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/")!
    
    func createMessageThread (with title: String, completion: @escaping (NSError?) -> Void) {
        let message = MessageThread()
        
        
        var components = URLComponents(url: MessageThreadController.baseURL, resolvingAgainstBaseURL: true)
        
        
        
        
    }
}
