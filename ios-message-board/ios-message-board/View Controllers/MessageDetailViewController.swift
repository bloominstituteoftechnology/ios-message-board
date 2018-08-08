//
//  MessageDetailViewController.swift
//  ios-message-board
//
//  Created by De MicheliStefano on 08.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func send(_ sender: Any) {
        guard let messageThread = messageThread,
            let sender = nameTextField?.text,
            let message = messageTextView?.text else { return }
        
        messageThreadController?.createMessage(for: messageThread, text: message, sender: sender, completion: { (error) in
            if let error = error {
                NSLog("Error saving new message thread: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
}
