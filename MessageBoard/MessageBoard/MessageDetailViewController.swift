//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Daniela Parra on 9/12/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let senderName = nameTextField.text,
            let messageText = messageTextView.text,
            let messageThread = messageThread else { return }
        
        messageThread.createMessage(messageThread: messageThread, text: messageText, sender: senderName) { (_) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UILabel!
    
}
