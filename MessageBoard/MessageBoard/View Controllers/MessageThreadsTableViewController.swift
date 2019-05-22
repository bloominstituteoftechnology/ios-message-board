//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title

        return cell
    }
    
    
    @IBAction func textFieldAction(_ sender: Any) {
        guard let userText = messageThreadTextField.text, !userText.isEmpty else { return }
        
        messageThreadController.createMessageThread(title: userText) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "TableViewSegue" {
            guard let destinationVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThreadController.messageThreads[index.row]
            
        }
    }
    

    @IBOutlet weak var messageThreadTextField: UITextField!
    
    var messageThreadController = MessageThreadController()
    
}
