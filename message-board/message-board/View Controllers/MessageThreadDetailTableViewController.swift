//
//  MessageThreadDetailTableViewController.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		tableView.reloadData()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let title = messageThread?.title {
			self.title = title
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageThread?.messages.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
		guard let message = messageThread?.messages[indexPath.row] else { return cell }
		
		cell.textLabel?.text = message.text
		cell.detailTextLabel?.text = message.sender
		
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "MessageDetailSegue" {
			guard let vc = segue.destination as? MessageDetailViewController,
			let messageThread = messageThread else { return }
			
				vc.messageThread = messageThread
			
		}
	}
	
	
	var messageThread: MessageThread?
	var meseageThreadController: MessageThreadController?

}
