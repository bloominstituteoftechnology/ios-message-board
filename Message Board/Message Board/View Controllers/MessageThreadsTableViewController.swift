//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Moses Robinson on 1/23/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createThread(_ sender: Any) {
        guard let title = threadTextField.text, !title.isEmpty else { return }
        
        messageThreadController.createMessageThread(title: title) { (error) in
            if let error = error {
                NSLog("error finding messagethread: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.threadTextField.text = ""
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }
    
    let reuseIdentifier = "MessageThreadCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        
        return cell
    }
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     }
     }
     */
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessages" {
            guard let destination = segue.destination as? MessageThreadDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destination.messageThreadController = messageThreadController
            destination.messageThread = messageThreadController.messageThreads[indexPath.row]
        }
    }
    
    // MARK : - Properties
    
    let messageThreadController = MessageThreadController()
    
    @IBOutlet weak var threadTextField: UITextField!
}
