//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Dillon McElhinney on 9/12/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThread?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        guard let message = messageThread?.sortedMessages[indexPath.row] else { return UITableViewCell()}
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = "\(message.formattedTimestamp) - \(message.sender)"

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMessageSegue" {
            let destinationVC = segue.destination as! MessageDetailViewController
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }

}
