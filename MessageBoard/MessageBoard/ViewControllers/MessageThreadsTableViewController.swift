//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Carolyn Lea on 8/8/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController
{
    @IBOutlet weak var textField: UITextField!
    var messageThreadController = MessageThreadController()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error
            {
                NSLog("problem fetching message \(error)")
                return
            }
        }
        self.tableView.reloadData()
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: Any)
    {
        guard let title = textField.text else {return}
        print(title)
        messageThreadController.createMessageThread(title: title) { (error) in
            if let error = error
            {
                NSLog("problem creating new messageThread \(error)")
                return
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBoardCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title

        return cell
    }
    

    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
       if segue.identifier == "ShowMessageThreadTableView"
       {
            guard let messageThreadView = segue.destination as? MessageThreadDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            messageThreadView.messageThreadController = messageThreadController
            messageThreadView.messageThread = messageThreadController.messageThreads[indexPath.row]
       }
    }
    

}
