//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Lisa Sampson on 5/8/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    // MARK: - Properties and Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    // MARK: - IBActions
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        guard let name = textField.text,
            let message = textView.text,
            let thread = messageThread else { return }
        
        messageThreadController?.createMessage(thread: thread, text: message, sender: name, completion: { (success) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}
