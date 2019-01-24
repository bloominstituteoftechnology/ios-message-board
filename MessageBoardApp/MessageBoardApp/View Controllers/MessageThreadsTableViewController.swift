//
//  MessageThreadsTableViewController.swift
//  MessageBoardApp
//
//  Created by Nelson Gonzalez on 1/23/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    @IBOutlet weak var messageBoardTextField: UITextField!
//    In the MessageThreadsTableViewController, add a messageThreadController: MessageThreadController property. Set its default value to a new instance of MessageThreadController.
    var messageThreadController: MessageThreadController = MessageThreadController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        messageThreadController.fetchMessageThreads { (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageBoardCell", for: indexPath)

       let messages = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = messages.title

        return cell
    }
  

    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessageDetailTableVC" {
            let destinationVC = segue.destination as? MessageThreadDetailTableViewController
            destinationVC?.messageThreadController = messageThreadController
            guard let  indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC?.messageThread = messageThreadController.messageThreads[indexPath.row]
        }
    }
   
    @IBAction func textFieldAction(_ sender: UITextField) {
//        In the action of the text field, unwrap its text and call the createMessageThread method, passing in the unwrapped text for the new thread's title. In the completion closure of createMessageThread, reload the table view on the main queue.
        
        guard let text = messageBoardTextField.text, !text.isEmpty else {return}
        messageThreadController.createMessageThread(with: text) { (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
