//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Madison Waters on 9/19/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    let messageThreadController = MessageThreadController()
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func messageTextAction(_ sender: Any) {
        guard let title = messageTextField.text else { return }
        
        messageThreadController.createMessageThread(title: title) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
