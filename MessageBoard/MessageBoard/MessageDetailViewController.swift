import UIKit

class MessageDetailViewController: UIViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendButtonWasTapped(_ sender: Any) {
        guard let name = nameTextField.text,
        let message = messageTextView.text,
            let thread = messageThread else { return }
        
        messageThreadController?.createMessage(thread: thread, text: message, sender: name, completion: { (success) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
        
        
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    

}
