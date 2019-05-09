//
//  MessageDetailViewController.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	
	@IBOutlet var nameTextField: UITextField!
	@IBOutlet var messageTextView: UITextView!
	var messageThread: MessageThreadController?
	var messageThreadController: MessageThreadController?
}
