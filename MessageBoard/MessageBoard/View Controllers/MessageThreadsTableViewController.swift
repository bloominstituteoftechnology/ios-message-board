//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/15/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    var messageThreadController: MessageThreadController = MessageThreadController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageDetail" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            let messageDetailVC = segue.destination as? MessageThreadDetailTableViewController
            let messageThread = messageThreadController.messageThreads[index.row]
            messageDetailVC?.messageThread = messageThread
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

        return cell
    }
 
    
    
    @IBAction func messageTextField(_ sender: Any) {
        guard let messageThreadText = textField.text else { return }
        messageThreadController.createMessageThread(title: messageThreadText) { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
  
    
    @IBOutlet weak var textField: UITextField!
    

}
