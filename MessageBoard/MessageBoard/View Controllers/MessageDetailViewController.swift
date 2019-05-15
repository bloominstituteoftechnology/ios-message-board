//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/15/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let sender = messageDetailVCTextField.text, !sender.isEmpty,
            let text = messageDetailVCTextView.text, !text.isEmpty,
            let messageThread = messageThread else { return }
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: sender, completion: { error in
            if let error = error {
                print(error)
                return
            }
           //pop VC on the main queue ??
        })
    }
    
    
    @IBOutlet weak var messageDetailVCTextView: UITextView!
    @IBOutlet weak var messageDetailVCTextField: UITextField!
}
