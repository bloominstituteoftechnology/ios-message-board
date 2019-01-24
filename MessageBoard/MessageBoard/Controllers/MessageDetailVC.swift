//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class MessageDetailVC: UIViewController {

    //MARK: Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func send(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

