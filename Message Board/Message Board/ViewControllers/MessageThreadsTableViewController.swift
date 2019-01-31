//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Welinkton on 9/20/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    var messageThreadController = MessageThreadController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func createNewThread(_ sender: Any) {
    
        guard let messageTitle = messageTextField.text else {return}
       
        
        // ???
        messageThreadController.createMessageThread(title: messageTitle) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    

    @IBOutlet weak var messageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = messageThread.title
        
        return cell

    }
    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? MessageThreadDetailTableViewController else {return}
            
            let messageThread = messageThreadController.messageThreads[indexPath.row]
                destinationVC.messageThreadController = messageThreadController
                destinationVC.messageThread =  messageThread
        }
    }
    

}
