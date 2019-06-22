//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Daniela Parra on 9/12/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = messageThread.title

        return cell
    }

    
    
    @IBAction func createNewThread(_ sender: UITextField) {
        guard let threadTitle = boardTextField.text else { return }
        
        messageThreadController.createMessageThread(title: threadTitle) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ViewThread" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destintationVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            
            let messageThread = messageThreadController.messageThreads[indexPath.row]
            
            destintationVC.messageThreadController = messageThreadController
            destintationVC.messageThread = messageThread
        }
    }
    
    @IBOutlet weak var boardTextField: UITextField!
    
    var messageThreadController = MessageThreadController()
    
}
