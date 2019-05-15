//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Kobe McKee on 5/15/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = messageThread?.messages.count else { return 0 }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        let message = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender
        
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMessageSegue" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            destinationVC.messageThread = messageThread
            destinationVC.messageThreadController = messageThreadController
        }

    }

}
