//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let text = detailTextField.text, !text.isEmpty else { return }
        guard let messageThread = messageThread else { return }
        guard let viewText = detailTextView.text , !viewText.isEmpty else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: viewText, sender: text, completion: { (error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
        
        
    }
    
    
    @IBOutlet weak var detailTextField: UITextField!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
