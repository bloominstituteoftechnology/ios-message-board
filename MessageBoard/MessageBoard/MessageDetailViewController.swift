//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Nikita Thomas on 10/23/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBAction func sendButton(_ sender: Any) {
        if let textField = textField.text, let textView = textView.text, let messageThread = messageThread {
            messageThreadController?.createMessage(thread: messageThread, text: textView, sender: textField, completion: { _ in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
            })

    }
}
}
