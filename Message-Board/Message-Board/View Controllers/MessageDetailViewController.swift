import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var messageView: UITextView!
    var message: MessageThread.Message?
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    @IBAction func sendAction(_ sender: Any) {
        guard let messageThreadController = messageThreadController,
            let messageThread = messageThread,
            let sender = nameField.text,
            let text = messageView.text else { return }
        
        messageThreadController.createMessage(in: messageThread, text: text, sender: sender) { (error) -> (Void) in
            DispatchQueue.main.async { self.navigationController?.popViewController(animated: true) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let message = message else { return }
        
        if message.text == "" { title = message.sender } else {
            title = message.text
        }
        
        nameField.text = message.sender
        messageView.text = message.text
    }
    
    
    
}
