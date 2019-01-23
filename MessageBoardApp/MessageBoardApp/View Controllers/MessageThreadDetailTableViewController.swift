//
//  MessageThreadDetailTableViewController.swift
//  MessageBoardApp
//
//  Created by Nelson Gonzalez on 1/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
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
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageThread?.messages.count ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageDetailCell", for: indexPath)

        let messageDetail = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = messageDetail?.text
        cell.detailTextLabel?.text = messageDetail?.sender

        return cell
    }
  

  

    
    // MARK: - Navigation

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? MessageDetailViewController
            destinationVC?.messageThreadController = messageThreadController
            destinationVC?.messageThread = messageThread
        }
    }
   

}
