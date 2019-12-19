//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Carolyn Lea on 8/8/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController
{
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageThread?.messages.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        let message = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender
        
        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
       if segue.identifier == "ToMessageDetailView"
       {
            guard let messageDetailView = segue.destination as? MessageDetailViewController else {return}
            messageDetailView.messageThreadController = messageThreadController
            messageDetailView.messageThread = messageThread
        }
    }
    

}
