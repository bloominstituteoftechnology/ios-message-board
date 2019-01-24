//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Julian A. Fordyce on 1/23/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail cell", for: indexPath)
        let message = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = message?.sender
        cell.detailTextLabel?.text = message?.text
        
        return cell
    }




    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destination = segue.destination as! MessageDetailViewController
            destination.messageThreadController = messageThreadController
            destination.messageThread = messageThread
    
        }
    }

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}


var messageThread: MessageThread?
var messageThreadConter: MessageThreadController?

