//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by morse on 5/8/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    @IBOutlet var addThreadTextField: UITextField!
    
    // "In the MessageThreadsTableViewController, add a messageThreadController: MessageThreadController property. Set its default value to a new instance of MessageThreadController." Does this mean what I did on line 15?
    var messageThreadController = MessageThreadController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads { error in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
    
    @IBAction func returnPressed(_ sender: Any) {
        guard let title = addThreadTextField.text else { return }
        messageThreadController.createMessageThread(title: title) { error in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()                
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ThreadDetailSegue" {
            guard let threadDetailVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            guard let messageIndexPath = tableView.indexPathForSelectedRow else { return }
            
            threadDetailVC.messageThreadController = messageThreadController
            threadDetailVC.messageThread = messageThreadController.messageThreads[messageIndexPath.row]
        }
    }
}
