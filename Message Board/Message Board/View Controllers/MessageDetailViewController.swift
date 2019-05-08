//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Michael Redig on 5/8/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

	var messageThread: MessageThread?
	var messageThreadController: MessageThreadController?

	@IBOutlet var nameTextField: UITextField!
	@IBOutlet var messageTextView: UITextView!

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
		guard let name = nameTextField.text, let message = messageTextView.text else { return }
		guard let messageThread = messageThread else { return }
		messageThread.createMessage(on: messageThread, text: message, sender: name, completion: { [weak self] (error) in
			if let error = error {
				print("error: \(error)")
				return
			}
			self?.navigationController?.popViewController(animated: true)
		})
	}
}
