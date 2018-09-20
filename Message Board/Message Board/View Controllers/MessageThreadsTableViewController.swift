//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Scott Bennett on 9/19/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    @IBOutlet weak var threadTextField: UITextField!
    
    var messageThreadController = MessageThreadController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessagesThread { (_) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        return cell
    }
        
    @IBAction func newThreadCreated(_ sender: Any) {
        guard let text = threadTextField.text else { return }
        messageThreadController.createMessageThread(title: text) { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

  
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowThread" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            
            let messageThread = messageThreadController.messageThreads[indexPath.row]
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }

}

