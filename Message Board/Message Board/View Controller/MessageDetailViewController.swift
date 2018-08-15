//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Iyin Raphael on 8/15/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
   

    @IBAction func Send(_ sender: Any) {
        guard let sender = textField.text,
            let text = textView.text,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: sender, completion: { (error) in
            if let error = error {
                NSLog("Error creating new message: \(error)")
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
  

}
