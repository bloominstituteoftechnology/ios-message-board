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
    
    @IBOutlet weak var messageThreadTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addNewMessageThread(_ sender: Any) {
        guard let title = messageThreadTextField.text, !title.isEmpty else { return }
        
        messageThreadController.createMessageThread(title: title) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.messageThreadTextField.text = ""
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = messageThread.title

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageThreadSegue" {
            let destinationVC = segue.destination as! MessageThreadDetailTableViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let messageThread = messageThreadController.messageThreads[indexPath.row]
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }

}
