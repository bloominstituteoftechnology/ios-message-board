//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Linh Bouniol on 8/8/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var messageThreadController = MessageThreadController()

    // MARK: - Outlets/Actions
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func textField(_ sender: Any) {
        guard let title = textField.text, title.count > 0 else { return }
        
        messageThreadController.createMessageThread(withTitle: title) { (error) in
            if let error = error {
                NSLog("Error creating message thread: \(error)")
                return
            }
        
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("Error fetching message threads: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let message = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = message.title

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageDetail" {
            let threadDetailVC = segue.destination as? MessageThreadDetailTableViewController
            threadDetailVC?.messageThreadController = messageThreadController
            
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            let messageThread = messageThreadController.messageThreads[index]
            threadDetailVC?.messageThread = messageThread
        }
    }
    

}
