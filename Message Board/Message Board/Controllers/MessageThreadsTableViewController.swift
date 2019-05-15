//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Ryan Murphy on 5/15/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    var messageThreadController: MessageThreadController = MessageThreadController()
    
    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("error fetching data: \(error)")
            }
        }
    }
    
    @IBAction func messageFieldExit(_ sender: Any) {
        guard let text = messageTextField.text else {
            return
        }
        messageThreadController.createMessageThread(title: text) { (error) in
            if let error = error {
                NSLog("Error getting text from messageTextField \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.messageTextField.text = ""
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = messageThread.title
        // Configure the cell...

        return cell
    }
    


  

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSegue" {
            guard let destinationVC = segue.destination as? MessageThreadDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else{ return }
            
            let messageThread = messageThreadController.messageThreads[indexPath.row]
            destinationVC.messageThread = messageThread
            destinationVC.messageThreadController = messageThreadController
        }
        
    }
    

}
