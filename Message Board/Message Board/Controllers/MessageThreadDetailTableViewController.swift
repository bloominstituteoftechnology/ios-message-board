//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Ryan Murphy on 5/15/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
 
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = messageThread?.title ?? ""
        //twice in the same project ... wow.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // THANK YOU STACK!!!!!!
        return messageThread?.messages.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let message = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender
        // Configure the cell...

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailShowSegue" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            
            destinationVC.messageThread = messageThread
            destinationVC.messageThreadController = messageThreadController
            
        }
     
    }
    

}
