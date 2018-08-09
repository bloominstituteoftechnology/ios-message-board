//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Carolyn Lea on 8/8/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController
{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBAction func send(_ sender: Any)
    {
        guard let messageThread = messageThread,
            let name = nameTextField.text,
            let messageText = textView.text else {return}
        
        messageThreadController?.createMessage(messageThread: messageThread, text: messageText, sender: name, completion: { (error) in
            if let error = error
            {
                NSLog("problem creating new messageThread \(error)")
                return
            }
            
        })
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
