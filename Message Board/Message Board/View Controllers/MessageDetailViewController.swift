//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Lisa Sampson on 8/15/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sendButtonWasTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
            let message = messageTextView.text,
            let thread = messageThread else { return }
        
        messageThreadController?.createMessage(thread: thread, text: message, sender: name, completion: { (success) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
}
