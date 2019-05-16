//
//  MessageThreadTableViewController.swift
//  iOSMessageBoard
//
//  Created by Jonathan Ferrer on 5/15/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    var messageThread: MessageThread?
    var messageThreadcontroller: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = messageThread?.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessage" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            destinationVC.messageThread = messageThread
            destinationVC.messageThreadController = messageThreadcontroller
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let messageThread = messageThread else { return 0}
        return messageThread.messages.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        let message = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender
        

        return cell
    }




}
