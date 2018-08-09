//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Jeremy Taylor on 8/8/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("Error fetching data from server: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


    @IBAction func message(_ sender: Any) {
        guard  let messageText = messageTextField.text else { return }
        
        messageThreadController.createMessageThread(withTitle: messageText) { (error) in
            if let error = error {
                NSLog("Error creating message on server: \(error)")
            
            }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
    

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]

        // Configure the cell...
        cell.textLabel?.text = messageThread.title
        

        return cell
    }
    

    let messageThreadController = MessageThreadController()
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destVC = segue.destination as! MessageThreadDetailTableViewController
            destVC.messageThreadController = messageThreadController
            destVC.messageThread = messageThreadController.messageThreads[indexPath.row]
            
        }
    }
}
