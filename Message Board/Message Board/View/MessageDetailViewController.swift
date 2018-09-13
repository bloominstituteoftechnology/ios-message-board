//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Dillon McElhinney on 9/12/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Message"
    }
    
    // UI Methods
    @IBAction func sendMessage(_ sender: Any) {
        guard let text = messageTextView.text, !text.isEmpty,
            let sender = nameTextField.text, !sender.isEmpty,
        let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: sender, completion: { (_) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }

}
