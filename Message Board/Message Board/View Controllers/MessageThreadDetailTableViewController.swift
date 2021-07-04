//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Madison Waters on 9/19/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)

        guard let messageThread = messageThread else { return UITableViewCell() }
        
        cell.textLabel?.text = messageThread.messages[indexPath.row].text
        cell.detailTextLabel?.text = messageThread.messages[indexPath.row].sender

        return cell
    }
 
    // MARK: - Navigation // messageDetail // detailTableToViewController

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailTableToViewController" {
            
            guard let messageVC = segue.destination as? MessageDetailViewController,
            let messageThreadController = messageThreadController,
            let messageThread = messageThread else { return }
            
            messageVC.messageThread = messageThread
            messageVC.messageThreadController = messageThreadController
        }
    }
    
}
