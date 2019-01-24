//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard Project
//
//  Created by Michael Flowers on 1/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    var messageThread: MessageThread?
    var mtc: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let message = messageThread else { return }
        title = message.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() 
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let messages = messageThread?.messages else { return 0 }
        return messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        // Configure the cell...
        guard let message = messageThread?.messages[indexPath.row] else { return UITableViewCell()  }
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
      if segue.identifier == "addSegue" {
            guard let toDestinationVc = segue.destination as? MessageDetailViewController  else { return }
        
            toDestinationVc.mtc = mtc
            toDestinationVc.messageThread = messageThread
        }
    }

}
