//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Lisa Sampson on 8/15/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    @IBAction func messageThreadWasReturned(_ sender: Any) {
        guard let title = messageThreadTextField.text else { return }
        
        messageThreadController.createMessageThread(title: title) { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        let message = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = message.title

        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailTableView" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let detailTVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            let message = messageThreadController.messageThreads[indexPath.row]
            detailTVC.messageThread = message
            detailTVC.messageThreadController = messageThreadController
        }
        
    }
    
    let messageThreadController = MessageThreadController()
    
    @IBOutlet weak var messageThreadTextField: UITextField!
    
}
