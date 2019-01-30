//
//  MessageDetailTableViewController.swift
//  w3r MessageBoard
//
//  Created by Michael Flowers on 1/30/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageDetailTableViewController: UITableViewController {
    
    var messageThread: MessageThread?
    var mtc: MessageThreadController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThread?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath)
        
        let message = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender
        
        // Configure the cell...

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addSegue" {
            guard let toDestinationVC = segue.destination as? MessageViewController else { return }
          
            toDestinationVC.mtc = mtc
            toDestinationVC.messageThread = messageThread
        }
        
    }
 

}
