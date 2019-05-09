//
//  MessageThreadDetailTableViewController.swift
//  message-board
//
//  Created by Hector Steven on 5/8/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageThread?.messages.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
		guard let message = messageThread?.messages[indexPath.row] else { return cell }
		
		
		
		cell.textLabel?.text = message.text
		cell.detailTextLabel?.text = message.sender
		
		return cell
	}
	
	
	var messageThread: MessageThread?
	var meseageThreadController: MessageThreadController?

}
