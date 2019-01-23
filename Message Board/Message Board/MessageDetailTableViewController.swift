//
//  MessageDetailTableViewController.swift
//  Message Board
//
//  Created by Nathanael Youngren on 1/23/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class MessageDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        guard let messages = messageThread?.messages else { return cell }
        
        let message = messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMessageSegue" {
            guard let messageDetailVC = segue.destination as? MessageDetailViewController else { return }
            
            messageDetailVC.messageThread = messageThread
            messageDetailVC.messageThreadController = messageThreadController
        }
    }
    
    // Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

}
