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
    
        
    }
    
    
    @IBOutlet weak var messageDetailVCTextView: UITextView!
    @IBOutlet weak var messageDetailVCTextField: UITextField!
}
