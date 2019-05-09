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
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }
	
	@objc func save() {
		guard let name = nameTextField.text,
			let message = messageTextView.text,
			let messeageThread = messageThread else { return }
		
		print(name, message)
		
		messageThreadController?.createMessage(messageThread: messeageThread, text: message, sender: name, completion: { (error) in
			if let error = error {
				print(error)
			}
			
			DispatchQueue.main.async {
			}
		})
		
		self.navigationController?.popToRootViewController(animated: true)
		nameTextField?.text = nil
		messageTextView?.text = nil
	}
	
	@IBOutlet var nameTextField: UITextField!
	@IBOutlet var messageTextView: UITextView!
	var messageThread: MessageThread?
	var messageThreadController: MessageThreadController?
}
