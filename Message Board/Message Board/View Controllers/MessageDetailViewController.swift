//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Michael Redig on 5/8/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

	@IBOutlet var nameTextField: UITextField!
	@IBOutlet var messageTextView: UITextView!

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
	}
}
