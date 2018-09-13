//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Daniela Parra on 9/12/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMessage(_ sender: Any) {
    }
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UILabel!
    
}
