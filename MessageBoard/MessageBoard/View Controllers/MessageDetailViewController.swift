//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Jeffrey Carpenter on 5/8/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        resignFirstResponder()
        
        guard let sender = textField.text,
        let messageText = textView.text,
        let messageThread = messageThread
        else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: messageText, sender: sender) { error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
