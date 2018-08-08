//
//  MessageThreadDetailTableViewController.swift
//  ios-message-board
//
//  Created by De MicheliStefano on 08.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = messageThread?.title ?? ""
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let message = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageDetail" {
            guard let detailVC = segue.destination as? MessageDetailViewController else { return }
            detailVC.messageThread = messageThread
            detailVC.messageThreadController = messageThreadController
        }
    }
    
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

}
