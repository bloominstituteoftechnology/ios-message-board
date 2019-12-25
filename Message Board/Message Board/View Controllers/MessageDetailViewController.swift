//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Linh Bouniol on 8/8/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    // MARK: - Outlets/Actions
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var messageTextView: UITextView!
    
    @IBAction func send(_ sender: Any) {
        guard let messageThread = messageThread, let name = nameTextField.text, let text = messageTextView.text else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: name, completion: { (error) in
            if let error = error {
                NSLog("Error creating message: \(error)")
                return
            }
            
//            DispatchQueue.main.async { // no longer necessary, since we made sure createMessage's completion handler is thread safe
            self.navigationController?.popViewController(animated: true)
//            }
        })
    }
}
