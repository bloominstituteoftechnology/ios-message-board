//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Nathanael Youngren on 1/23/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
}
