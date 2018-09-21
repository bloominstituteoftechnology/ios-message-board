//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Madison Waters on 9/19/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    let messageThreadController: MessageThreadController = MessageThreadController()
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func messageTextAction(_ sender: Any) {
        guard let title = messageTextField.text else { return }
        
        /// In the action call the createMessageThread method, pass in the unwrapped text for the new thread's title.
        /// In the completion closure of createMessageThread, reload the table view on the main queue.
        
        messageThreadController.createMessageThread(title: title) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//     Finally, in the MessageThreadsTableViewController, call the viewWillAppear method. Inside of it, call the messageThreadController's fetchMessageThreads method. In the completion closure, //reload the table view on the main queue. This will allow the table view controller to fetch any new threads and messages made every time this table view controller appears.
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = messageThread.title
        cell.detailTextLabel?.text = messageThread.identifier

        return cell
    }

    // MARK: - Navigation // messageDetail // detailTableToViewController

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageDetail" {
            
            guard let messageThreadVC = segue.destination as? MessageThreadDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
                let messageThread = messageThreadController.messageThreads[indexPath.row]
            
                messageThreadVC.messageThread = messageThread
                messageThreadVC.messageThreadController = messageThreadController
        }
    }
 
}
