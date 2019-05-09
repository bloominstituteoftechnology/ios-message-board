//
//  ViewController.swift
//  Message Board
//
//  Created by Michael Redig on 5/8/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

	let messageThreadController = MessageThreadController()

	@IBOutlet var topTextField: UITextField!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		messageThreadController.fetchMessageThreads { [weak self] (error) in
			if let error = error {
				print("error loading data: \(error)")
				return
			}
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}

	@IBAction func topTextFieldEndedEditing(_ sender: UITextField) {
		guard let text = sender.text else { return }

		messageThreadController.createMessageThread(title: text) { [weak self] (error) in
			if let error = error {
				print("error: \(error)")
				return
			}
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowDetailTable" {
			if let dest = segue.destination as? MessageThreadDetailTableViewController,
				let indexPath = tableView.indexPathForSelectedRow {
				dest.messageThreadController = messageThreadController
				dest.messageThread = messageThreadController.messageThreads[indexPath.row]
			}
		}
	}
}

extension MessageThreadsTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageThreadController.messageThreads.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AnIdentifier", for: indexPath)

		cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title
		return cell
	}
}
