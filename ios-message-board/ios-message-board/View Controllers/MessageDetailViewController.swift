//
//  MessageDetailViewController.swift
//  ios-message-board
//
//  Created by Conner on 8/8/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addMessage(_ sender: Any) {
        guard let textField = textField.text,
            let textView = textView.text,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: textView, sender: textField, completion: { (error) in
            
            if let error = error {
                NSLog("There was an error creating a message for this thread: \(messageThread): \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    // MARK: - Properties
    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
