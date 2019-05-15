//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Hayden Hastings on 5/15/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

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
        guard let count = messageThread?.messages.count else { return 0 }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewMessageCell", for: indexPath)

        let message = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = message?.text
        cell.textLabel?.text = message?.sender

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToNewMessage" {
            guard let messageVC = segue.destination as? MessageDetailViewController else { return }
            
            messageVC.messageThread = messageThread
            messageVC.messageThreadController = messageThreadController
        }
    }
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
