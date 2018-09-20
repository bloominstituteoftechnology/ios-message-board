//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Scott Bennett on 9/19/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    
    @IBAction func sendMessage(_ sender: Any) {
        guard let nameText = nameTextField.text,
            let messageText = messageTextView.text,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: messageText, sender: nameText, completion: { (error) in
            if let error = error {
                NSLog("Error creating message: \(error)")
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }

}
