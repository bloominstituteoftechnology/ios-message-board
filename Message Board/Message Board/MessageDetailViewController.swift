//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Nathanael Youngren on 1/23/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = messageThread?.title
    }
    
    @IBAction func sendButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
            let message = messageTextView.text,
            let messageThread = messageThread,
            let messageThreadController = messageThreadController else { return }
        
        messageThreadController.createMessage(messageThread: messageThread, text: message, sender: name) { (error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
}
