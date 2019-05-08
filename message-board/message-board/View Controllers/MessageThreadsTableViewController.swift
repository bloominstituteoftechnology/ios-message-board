//
//  MessageThreadsTableViewController.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		controller.CreateMessageThread(title:  "one") { (error) in
			if let error = error {
				print(error)
			}
		}
	}
	
	
	@IBAction func messageBoardTextFieldDidEndOnExit(_ sender: UITextField) {
		guard let text = sender.text else {
			return
		}
		
		print(text)
	}
	

	let controller = MessageThreadController()
}