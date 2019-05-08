//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Jeffrey Carpenter on 5/8/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = messageThread?.title ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        guard let message = messageThread?.messages[indexPath.row] else { return cell }
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddMessage" {
            
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }
}
