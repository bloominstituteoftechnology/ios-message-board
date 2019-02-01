//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Paul Yi on 1/30/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    let messageThreadController = MessageThreadController()
    
    // Create an instance of the UIRefreshControl class
    let messageThreadRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var messageThreadTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure Refresh Control by adding a target and an action for the valueChanged event
        messageThreadRefreshControl.addTarget(self, action: #selector(fetchMessageThreads), for: .valueChanged)
        // Add Refresh Control to Table View
        tableView.refreshControl = messageThreadRefreshControl

    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageThreadController.fetchMessageThreads { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func returnMessageThread(_ sender: Any) {
        guard let title = messageThreadTextField.text else { return }
        
        messageThreadController.createMessageThread(title: title) { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        messageThreadTextField.text = ""
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
        if segue.identifier == "ShowMessageThread" {
            guard let indexPath  = tableView.indexPathForSelectedRow,
                let detailTVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            let message = messageThreadController.messageThreads[indexPath.row]
            detailTVC.messageThread = message
            detailTVC.messageThreadController = messageThreadController
        }
    }
    
    @objc private func fetchMessageThreads() {
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.messageThreadRefreshControl.endRefreshing()
            }
        }
    }

}
