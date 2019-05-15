//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Kobe McKee on 5/15/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    let messageThreadController = MessageThreadController()
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func messageTextFieldAction(_ sender: Any) {
        
        guard let title = messageTextField.text else { return }
        print("creating new message thread")
        messageTextField.text = ""
        messageThreadController.createMessageThread(title: title) { (error) in
            if let error = error {
                NSLog("Error creating new message thread: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("Error fetching message threads: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title

        return cell
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageDetailSegue" {
            guard let destinationVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            guard let index = tableView.indexPathForSelectedRow else { return }
            destinationVC.messageThread = messageThreadController.messageThreads[index.row]
            destinationVC.messageThreadController = messageThreadController
        }
    }
    
    
    
    


}
