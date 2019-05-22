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
        
        
        
    }
    
    
    @IBOutlet weak var detailTextField: UITextField!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
