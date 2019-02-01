//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Paul Yi on 1/30/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var messageDetailTextField: UITextField!
    @IBOutlet weak var messageDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func send(_ sender: Any) {
        guard let name = messageDetailTextField.text,
            let message = messageDetailTextView.text,
            let thread = messageThread else { return }
        
        messageThreadController?.createMessage(thread: thread, text: message, sender: name, completion: { (success) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
}
