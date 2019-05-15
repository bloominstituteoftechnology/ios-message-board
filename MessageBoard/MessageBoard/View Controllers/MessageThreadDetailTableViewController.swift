//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Jeremy Taylor on 5/15/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard isViewLoaded else { return }
        title = messageThread?.title
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let messageThread = messageThread else { return 0 }
        return messageThread.messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        let message = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender

        return cell
    }
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageDetailVC" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }

}
