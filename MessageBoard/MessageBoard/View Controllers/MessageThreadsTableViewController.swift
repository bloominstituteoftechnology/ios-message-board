//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Jeremy Taylor on 5/15/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    @IBOutlet weak var messageTextField: UITextField!
    
    let messageThreadController: MessageThreadController = MessageThreadController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("Error fetching message threads: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func messageEntered(_ sender: Any) {
        guard let text = messageTextField.text else { return }
        messageThreadController.createMessageThread(withTitle: text) { (error) in
            if let error = error {
                NSLog("Error creating message: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.messageTextField.text = nil
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
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "ShowMessageThreadDetailVC" {
            guard let destinationVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThreadController.messageThreads[indexPath.row]
        }
    }
}
