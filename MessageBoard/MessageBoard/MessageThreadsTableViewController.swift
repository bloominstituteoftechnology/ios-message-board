//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Nikita Thomas on 10/23/18.
//  Copyright © 2018 Nikita Thomas. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    var messageThreadController = MessageThreadController()
    
    
    
    @IBAction func textFieldDidEnd(_ sender: Any) {
        if let text = textField.text {
            messageThreadController.createMessageThread(title: text) { _ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MessageThreadDetailTableViewController {
            destination.messageThreadController = messageThreadController
            guard let index = tableView.indexPathForSelectedRow else {return}
            destination.messageThread = messageThreadController.messageThreads[index.row]
        }
    }
}
