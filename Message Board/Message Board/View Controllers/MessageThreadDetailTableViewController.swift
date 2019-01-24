//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Moses Robinson on 1/23/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }
    
    let reuseIdentifier = "MessageDetailCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let message = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = message?.sender
        cell.detailTextLabel?.text = message?.text
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateMessage" {
            let destination = segue.destination as! MessageDetailViewController
            
            destination.messageThreadController = messageThreadController
            destination.messageThread = messageThread
        }
    }
    
    // MARK : - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
