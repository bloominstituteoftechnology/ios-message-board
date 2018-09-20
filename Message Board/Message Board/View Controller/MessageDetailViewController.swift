//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Ilgar Ilyasov on 9/19/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    // MARK: - App Lifecycle funstions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func sendBarButtonTapped(_ sender: Any) {
        guard let messageThread = messageThread,
            let name = nameTextField.text,
            let message = messageTextView.text else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: message, sender: name, completion: { (_) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}
