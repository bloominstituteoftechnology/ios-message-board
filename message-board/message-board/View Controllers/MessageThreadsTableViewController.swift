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
	}
	
	
	@IBAction func messageBoardTextFieldDidEndOnExit(_ sender: UITextField) {
		
		guard let text = sender.text else {
			return
		}
		
		print(text)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messageThreadController.messageThreads.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
		
		
		cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "" {
			guard let vc = segue.destination as? MessageThreadDetailTableViewController,
				let cell = sender as? UITableViewCell else {
				print("errro: prepare(for: segue")
				return
			}
			
			guard let indexpath = tableView.indexPath(for: cell) else { return }
			vc.meseageThreadController = messageThreadController
			vc.messageThread = messageThreadController.messageThreads[indexpath.row]
			
			
		}
	}
	
	let messageThreadController = MessageThreadController()
}
