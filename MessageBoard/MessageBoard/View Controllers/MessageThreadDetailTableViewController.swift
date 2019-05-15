//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/15/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = messageThread?.title

    }

    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMessage" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            let addDetailVC = segue.destination as? MessageDetailViewController
            let message = messageThreadController?.messageThreads[index.row]
            addDetailVC?.messageThread = message
        }
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (messageThreadController?.messageThreads.count)!
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadDetailCell", for: indexPath)

        let messages = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = messages?.text
        cell.detailTextLabel?.text = messages?.sender

        return cell
    }
 

}
