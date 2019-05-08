//
//  ViewController.swift
//  Message Board
//
//  Created by Michael Redig on 5/8/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

	var messageThread: MessageThread?
	var messageThreadController: MessageThreadController?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationItem.title = messageThread?.title
		tableView.reloadData()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowMessageDetail" {
			if let dest = segue.destination as? MessageDetailViewController {
				dest.messageThread = messageThread
				dest.messageThreadController = messageThreadController
			}
		}
	}
}

extension MessageThreadDetailTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageThread?.messages.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

		if let message = messageThread?.messages[indexPath.row] {
			cell.textLabel?.text = message.text
			cell.detailTextLabel?.text = message.sender
		}
		return cell
	}
}
