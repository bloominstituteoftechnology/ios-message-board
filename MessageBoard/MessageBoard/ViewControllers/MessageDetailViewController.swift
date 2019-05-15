//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Kobe McKee on 5/15/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!

    
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text,
            let message = messageTextView.text,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: message, sender: name, completion: { (error) in
            if let error = error {
                NSLog("Error creating new message: \(error)")
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Message"
    }
}
