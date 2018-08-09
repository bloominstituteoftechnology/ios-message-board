//
//  MessageThreadDetailTableViewController.swift
//  ios-message-board
//
//  Created by Conner on 8/8/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messageThread = messageThread {
            return messageThread.messages.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadDetailCell", for: indexPath)
        if let messageThread = messageThread?.messages[indexPath.row] {
            cell.textLabel?.text = messageThread.text
            cell.detailTextLabel?.text = messageThread.sender
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateThreadReplySegue" {
            if let vc = segue.destination as? MessageDetailViewController {
                vc.messageThreadController = messageThreadController
                vc.messageThread = messageThread
            }
        }
    }
    
    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
