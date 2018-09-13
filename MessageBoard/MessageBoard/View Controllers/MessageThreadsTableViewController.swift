//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Farhan on 9/12/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    @IBOutlet weak var newThreadField: UITextField!
    var messageThreadController = MessageThreadController()
    
    @IBAction func createNewThread(_ sender: Any) {
        guard let threadTitle = newThreadField.text else {return}
        
        messageThreadController.createMessageThread(title: threadTitle) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title
        
        return cell
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if segue.identifier == "ThreadSegue" {
            guard let destVC = segue.destination as? MessageThreadDetailTableViewController else {return}
            destVC.messageThreadController = messageThreadController
            
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let messageThread = messageThreadController.messageThreads[indexPath.row]
            
            destVC.messageThread = messageThread
        }
        
     }
    
    
}
