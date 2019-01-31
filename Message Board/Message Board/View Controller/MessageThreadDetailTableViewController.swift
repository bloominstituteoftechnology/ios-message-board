//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Ilgar Ilyasov on 9/19/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    // MARK: - App lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = messageThread?.title
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
        guard let newMessage = messageThread?.messages[indexPath.row] else { return cell}
        
        cell.textLabel?.text = newMessage.text
        cell.detailTextLabel?.text = newMessage.sender
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBarButtonSegue" {
            let destinationVC = segue.destination as! MessageDetailViewController
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }
}
