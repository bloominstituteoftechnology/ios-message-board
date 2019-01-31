//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Welinkton on 9/20/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return messageThread?.messages.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        guard let messageThread = messageThread else { return UITableViewCell() }
        
        let message = messageThread.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender
        
       return cell
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMessage" {
            guard let messageThread = messageThread,
                let messageThreadController = messageThreadController,
                let destinationVC = segue.destination as? MessageDetailViewController else {return}
            
            destinationVC.messageThread = messageThread
            destinationVC.messageThreadController = messageThreadController
        }
        
    }
    

}
