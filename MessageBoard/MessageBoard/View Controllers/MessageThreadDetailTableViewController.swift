//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let index = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "MessageDetailSegue" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            destinationVC.messageThread = messageThread
            destinationVC.messageThreadController = messageThreadController
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThread?.messages.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageDetailCell", for: indexPath)
        let message = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender

        return cell
    }
 

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

}
