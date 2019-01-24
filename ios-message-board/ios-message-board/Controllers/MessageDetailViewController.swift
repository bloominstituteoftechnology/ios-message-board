import UIKit

class MessageDetailViewController: UIViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var messageView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let name = nameLabel.text, let message = messageView.text else {return}
        messageThreadController?.createMessage(messageThread: messageThread!, text: message, sender: name, completion: { error in
            if let error = error {
                NSLog("Error using createMessage in DetailViewController: \(error)")
                return
            }
        })
        navigationController?.popViewController(animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
