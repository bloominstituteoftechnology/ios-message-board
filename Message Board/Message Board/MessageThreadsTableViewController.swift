//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Nathanael Youngren on 1/23/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                print(error)
                return
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)
        
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = messageThread.title

        return cell
    }
    
    @IBAction func textFieldSubmitted(_ sender: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        
        messageThreadController.createMessageThread(title: text) { (error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            guard let messageDetailTVC = segue.destination as? MessageDetailTableViewController,
            let messageIndexPath = tableView.indexPathForSelectedRow else { return }
            
            messageDetailTVC.messageThread = messageThreadController.messageThreads[messageIndexPath.row]
            messageDetailTVC.messageThreadController = messageThreadController
        }
    }
    
    // Properties
    
    @IBOutlet weak var textField: UITextField!
    
    let messageThreadController = MessageThreadController()

}
