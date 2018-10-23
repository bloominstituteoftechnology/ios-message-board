//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Yvette Zhukovsky on 10/23/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = messageThread?.title ?? ""
   
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThread?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

       let msg = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = msg?.text
        cell.detailTextLabel?.text = msg?.sender
        
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThread" {
            guard let DVC = segue.destination as? MessageDetailViewController else { return }
            DVC.messageThread = messageThread
           DVC.messageThreadController = messageThreadController
        }
        
    }
   

}
