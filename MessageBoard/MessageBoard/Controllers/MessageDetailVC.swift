//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class MessageDetailVC: UIViewController {

    //MARK: Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func send(_ sender: Any) {
        guard let sender = textField.text else { return }
        guard let text = textView.text else { return }
        guard let messageThread = messageThread else { return }
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: sender) { (error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

