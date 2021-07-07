//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Moin Uddin on 9/12/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        // Configure the cell...

        return cell
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessages" {
            guard let messageThreadsDetailTableVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            messageThreadsDetailTableVC.messageThread = messageThreadController.messageThreads[indexPath.row]
            messageThreadsDetailTableVC.messageThreadController = messageThreadController
        }
    }
   
    
    @IBAction func createThread(_ sender: Any) {
        guard let newMessageThread = newThreadTextField.text else { return }
        messageThreadController.createMessageThread(title: newMessageThread) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var newThreadTextField: UITextField!
    
    let messageThreadController: MessageThreadController = MessageThreadController()
    
}
