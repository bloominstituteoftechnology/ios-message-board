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

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationItem.title = messageThread?.messages.last?.text
	}

	@IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
		guard let name = nameTextField.text,
			let message = messageTextView.text,
			!name.isEmpty, !message.isEmpty
			else { return }
		guard let messageThread = messageThread else {
			print("no message thread")
			return }
		messageThread.createMessage(on: messageThread, text: message, sender: name, completion: { [weak self] (error) in
			if let error = error {
				print("error: \(error)")
				return
			}
			DispatchQueue.main.async {
				self?.navigationController?.popViewController(animated: true)
			}
		})
	}
}
