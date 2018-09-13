//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Dillon McElhinney on 9/12/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    // MARK: - Properties
    let messageThreadController = MessageThreadController()
    let messageThreadRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var messageThreadTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMessageThreads()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up refresh control
        messageThreadRefreshControl.addTarget(self, action: #selector(fetchMessageThreads), for: .valueChanged)
        
        //Add refresh control to the tableview
        tableView.refreshControl = messageThreadRefreshControl
    }

    // MARK: - UI Methods
    @IBAction func addNewMessageThread(_ sender: Any) {
        guard let title = messageThreadTextField.text, !title.isEmpty else { return }
        
        messageThreadController.createMessageThread(title: title) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.messageThreadTextField.text = ""
            }
        }
    }
    
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)
        let messageThread = messageThreadController.sortedMessageThreads[indexPath.row]
        
        cell.textLabel?.text = messageThread.title
        cell.detailTextLabel?.text = "\(messageThread.messages.count)"

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageThreadSegue" {
            let destinationVC = segue.destination as! MessageThreadDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let messageThread = messageThreadController.sortedMessageThreads[indexPath.row]
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }

    // MARK: - Private Utility Methods
    @objc private func fetchMessageThreads() {
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.messageThreadRefreshControl.endRefreshing()
            }
        }
    }
    
}
