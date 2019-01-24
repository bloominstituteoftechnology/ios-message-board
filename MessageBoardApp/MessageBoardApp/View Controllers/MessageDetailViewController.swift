//
//  ViewController.swift
//  MessageBoardApp
//
//  Created by Nelson Gonzalez on 1/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
    
     var messageThread: MessageThread?
     var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sendBarButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let name = nameTextField.text, !name.isEmpty, let message = messageTextView.text, !message.isEmpty, let messageThread = messageThread else {return}
        
        messageThreadController?.createMessage(messageThread: messageThread, text: message, sender: name, completion: { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        })
    }
    
}

