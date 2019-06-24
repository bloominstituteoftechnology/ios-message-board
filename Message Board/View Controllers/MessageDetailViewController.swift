//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Jason Modisett on 9/12/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let message = message else { return }
        
        if message.text == "" { title = message.sender } else {
            title = message.text
        }
        
        textField.text = message.sender
        textView.text = message.text
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        guard let messageThreadController = messageThreadController,
            let messageThread = messageThread,
            let sender = textField.text,
            let text = textView.text else { return }
        
        messageThreadController.createMessage(in: messageThread, text: text, sender: sender) { (error) -> (Void) in
            DispatchQueue.main.async { self.navigationController?.popViewController(animated: true) }
        }
    }
    
    var message: MessageThread.Message?
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
}
