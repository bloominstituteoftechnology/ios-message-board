//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Jason Modisett on 9/12/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let messageThreadTitle = messageThread?.title else { return }
        title = messageThreadTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let messages = messageThread?.messages else { return 0 }
        return messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.messageCell.rawValue, for: indexPath)

        guard let messages = messageThread?.messages else { return cell }
        let message = messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender

        return cell
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? MessageDetailViewController,
              let messageThread = messageThread else { return }
        destVC.messageThreadController = messageThreadController
        destVC.messageThread = messageThread
        guard let index = messageThreadController?.messageThreads.index(of: messageThread),
              let indexRow = tableView.indexPathForSelectedRow?.row,
              let message = messageThreadController?.messageThreads[index].messages[indexRow] else { return }
        destVC.message = message
    }
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
