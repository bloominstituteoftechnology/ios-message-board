//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Farhan on 9/12/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = messageThread?.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rows =  messageThread?.messages.count else {return 0}
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = messageThread?.messages[indexPath.row].text
        let sender = messageThread?.messages[indexPath.row].sender
        let time = messageThread?.messages[indexPath.row].timestamp
        cell.detailTextLabel?.text = "\(sender) - \(time)"

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MessageSegue" {
            guard let destVC = segue.destination as? MessageDetailViewController else {return}
            destVC.messageThreadController = messageThreadController
            destVC.messageThread = messageThread
            
        }
        
    }
    
    
    
}
