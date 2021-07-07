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
		configureRefresh()
		fetchData()
	}

	func configureRefresh() {
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
	}

	@IBAction func topTextFieldEndedEditing(_ sender: UITextField) {
		guard let messageTitle = sender.text, !messageTitle.isEmpty else { return }

		messageThreadController.createMessageThread(title: messageTitle) { [weak self] (error) in
			if let error = error {
				print("error: \(error)")
				return
			}
			self?.messageThreadController.fetchMessageThreads(completion: { (error) in
				if let error = error {
					print("error \(error)")
				}
				DispatchQueue.main.async {
					self?.topTextField.text = error == nil ? "" : self?.topTextField.text
					self?.tableView.reloadData()
				}
			})
		}
	}

	@objc func fetchData() {
		tableView.refreshControl?.beginRefreshing()
		messageThreadController.fetchMessageThreads { [weak self] (error) in
			if let error = error {
				print("error loading data: \(error)")
				return
			}
			DispatchQueue.main.async {
				self?.tableView.reloadData()
				if self?.tableView.refreshControl?.isRefreshing ?? false {
					self?.tableView.refreshControl?.endRefreshing()
				}
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
