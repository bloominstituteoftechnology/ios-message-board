//
//  MessageThreadDetailTableViewController.swift
//  Message Board
//
//  Created by Iyin Raphael on 8/15/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (messageThread?.messages.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = messageThread?.messages[indexPath.row].sender
        cell.detailTextLabel?.text = messageThread?.messages[indexPath.row].text
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewMessage" {
            guard let detailVC = segue.destination as? MessageDetailViewController else {return}
            detailVC.messageThreadController = messageThreadController
            detailVC.messageThread = messageThread
        }
    }
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    


}
