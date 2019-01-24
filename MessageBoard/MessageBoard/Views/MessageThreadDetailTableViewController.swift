//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Angel Buenrostro on 1/23/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.title = self.messageThread?.title
        }
   
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread!.messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath)
        let detailedMessage = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = detailedMessage?.text
        cell.detailTextLabel?.text = detailedMessage?.sender

        return cell
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plusSegue"{
            let messageDetailVC = segue.destination as! MessageDetailViewController
            messageDetailVC.messageThreadController = messageThreadController
            messageDetailVC.messageThread = messageThread
        }
    }
    

}
