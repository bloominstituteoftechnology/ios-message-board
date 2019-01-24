//
//  MessageViews.swift
//  MessageBoard
//
//  Created by William Bundy on 8/8/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation
import UIKit

class TopicListTVC:UITableViewController
{
	@IBOutlet weak var newThreadField: UITextField!

	@IBAction func createNewThread(_ sender: Any)
	{
		guard let name = newThreadField.text, name != "" else {
			return
		}

		let topic = MessageTopic(name)
		App.controller.pushTopic(topic) { error in
			if error != nil {
				return
			}

			self.fetchData()
		}
	}

	func fetchData()
	{
		App.controller.fetchTopics { (err) in
			if err != nil {
				return
			}

			DispatchQueue.main.async {
				self.refreshControl?.endRefreshing()
				self.tableView.reloadData()
			}
		}
	}

	override func viewDidLoad()
	{
		refreshControl = UIRefreshControl(frame: tableView.frame)
		refreshControl?.addTarget(self, action: #selector(pullToRefresh(_ :)), for:.valueChanged)
		//fetchData()
	}

	@IBAction func pullToRefresh(_ sender: Any?)
	{
		fetchData()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return App.controller.topics.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell")!
		cell.textLabel!.text = App.controller.topics[indexPath.row].title
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? MessageListTVC {
			dest.topic = App.controller.topics[tableView.indexPathForSelectedRow!.row]
		}
	}
}

class MessageListTVC:UITableViewController
{
	var topic:MessageTopic!

	override func viewWillAppear(_ animated: Bool)
	{

	}

	func uiReload()
	{
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return topic.messages.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell")!
		cell.textLabel!.text = topic.messages[indexPath.row].text
		return cell
	}
}

class MessageDetailVC:UIViewController
{
	var message:Message!
	var topic:MessageTopic!
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var messageField: UITextView!
	@IBAction func sendMessage(_ sender: Any) {
		if message != nil {
			navigationController?.popViewController(animated: true)
			return
		}

		guard let name = nameField.text, name != "",
			let msg = messageField.text, msg != "" else {
				return
		}

		App.controller.pushMessage(Message(msg, name), topic: topic) {
			error in
			if let error = error {
				print(error)
			}
		}
		
	}

}
