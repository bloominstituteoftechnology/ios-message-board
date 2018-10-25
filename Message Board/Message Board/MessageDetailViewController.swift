import UIKit

class MessageDetailViewController: UIViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func sendMessageButton(_ sender: Any) {
        guard let sender = textField.text,
            let text = textView.text,
            let message = messageThread else { return }
        
        messageThreadController?.createMessage(thread: message, text: text, sender: sender, completion: { (success) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
