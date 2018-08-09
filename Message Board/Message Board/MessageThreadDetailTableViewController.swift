//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Jeremy Taylor on 8/8/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let messageThread = messageThread else { return }
        
        title = messageThread.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let messageThread = messageThread else { return 0 }
        return messageThread.messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let message = messageThread?.messages[indexPath.row]

        // Configure the cell...
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender

        return cell
    }
    

    
 
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMessage" {
            guard let messageThread = messageThread else { return }
            let destVC = segue.destination as! MessageDetailViewController
            destVC.messageThreadController = messageThreadController
            destVC.messageThread = messageThread
            
        }
    }
    

}
