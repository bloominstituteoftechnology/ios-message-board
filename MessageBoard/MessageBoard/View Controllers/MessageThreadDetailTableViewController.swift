//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Christopher Aronson on 5/8/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        print(messageThread)
        if let title = messageThread?.title {
            self.title = title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MessageThreadsDetailTableViewController viewWillAppear()")
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("MessageThreadsDetailTableViewController numberOfRows")
        guard let returnNumber = messageThread?.messages.count else { return 0 }
        return returnNumber
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("MessageThreadsDetailTableViewController cellForRow")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        guard let message = messageThread?.messages[indexPath.row] else { return cell }
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender

        return cell
    }
    
    // MARK: - prepare(for segue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageDetail" {
            let destinationVC: MessageDetailViewController = segue.destination as! MessageDetailViewController
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            guard let currentMessageThread = messageThreadController?.messageThread[index] else { return }
            destinationVC.messageThread = currentMessageThread
            destinationVC.messageThreadController = messageThreadController
        }
    }

    
    
}
