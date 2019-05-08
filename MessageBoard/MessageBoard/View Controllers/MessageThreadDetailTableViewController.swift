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
        if let title = messageThread?.title {
            self.title = title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let returnNumber = messageThread?.messages.count else { return 0 }
        return returnNumber
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        guard let message = messageThread?.messages[indexPath.row] else { return cell }
        cell.textLabel?.text = message.sender
        cell.detailTextLabel?.text = message.text

        return cell
    }
    
    // MARK: - prepare(for segue)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageDetail" {
                let destinatoinVC = segue.destination as! MessageDetailViewController
                destinatoinVC.messageThreadController = messageThreadController
                destinatoinVC.messageThread = messageThread
        }
    }

    
    
}
