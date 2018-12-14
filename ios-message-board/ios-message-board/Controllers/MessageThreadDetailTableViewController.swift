//
//  MessageThreadDetailTableViewController.swift
//  ios-message-board
//
//  Created by Austin Cole on 12/13/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        MessageThreadDetailTableViewController().title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(messageThread?.messages)
        return messageThread?.messages.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        cell.detailTextLabel?.text = messageThread?.messages[indexPath.row].text
        cell.textLabel?.text = messageThread?.messages[indexPath.row].sender
        
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? MessageDetailViewController
        
        destination?.messageThreadController = messageThreadController
        destination?.messageThread = messageThread
        
        
    }
}
