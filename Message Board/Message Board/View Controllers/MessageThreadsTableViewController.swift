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
        guard let text = messageTextField.text
            else { return }
        
        func reload() { DispatchQueue.main.async { self.tableView.reloadData() } }
        
        /////////// This is Broken /////////////
        
        /// In the action call the createMessageThread method, pass in the unwrapped text for the new thread's title.
        /// In the completion closure of createMessageThread, reload the table view on the main queue.
        messageThreadController.createMessageThread(title: text, identifier: UUID().uuidString, completion: DispatchQueue.main.async {
            reload()
        })
        
        /////////// This is Broken /////////////
        
        self.title = text
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let message = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = message.title
        cell.detailTextLabel?.text = message.identifier

        return cell
    }

    // MARK: - Navigation // messageDetail // detailTableToViewController

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                let messageThreadVC = segue.destination as? MessageThreadController else { return }
            
            let messages = messageThreadController.messageThreads[indexPath.row]
            
            messageThreadVC.messageThreads = messages
            messageThreadVC.messageThreadController = messageThreadController
            messageThreadVC.
        }
    }
 

}
