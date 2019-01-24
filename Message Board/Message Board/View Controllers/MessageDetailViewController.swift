//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Moses Robinson on 1/23/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendMessageTapped(_ sender: Any) {
        guard let sender = nameTextField.text, !sender.isEmpty,
            let text = messageTextView.text, !text.isEmpty,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: sender, completion: { (error) in
            if let error = error {
                NSLog("\(error)")
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
        
    }
    
    // MARK : - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
}
