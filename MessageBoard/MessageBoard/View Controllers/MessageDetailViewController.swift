//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by morse on 5/8/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let contents = contentsTextView.text, let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: contents, sender: name, completion: { error in
            if let error = error {
                print ("Error saving message: \(error)")
            }
        })
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
