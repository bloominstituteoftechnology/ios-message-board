//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Ryan Murphy on 5/15/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    var messageThreadController: MessageThreadController?
    var messageThread: MessageThread?
    
    @IBOutlet weak var addTextView: UITextView!
    @IBOutlet weak var addNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        
        guard let sender = addTextView.text else { return }
        guard let messageText = addNameTextField.text else { return }
        guard let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: messageText, sender: sender) { error in
            
            if let error = error {
                NSLog("Error with SaveButton Pressed: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
  
    

}
