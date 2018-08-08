//
//  MessageThreadsTableViewController.swift
//  ios-message-board
//
//  Created by De MicheliStefano on 08.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    
    @IBAction func create(_ sender: Any) {
        guard let title = threadTextField?.text else { return }
        
        messageThreadController.createMessageThread(withTitle: title) { (error) in
            if let error = error {
                NSLog("Error saving new message thread: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.threadTextField.text = ""
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title

        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowThreadDetail" {
            guard let detailVC = segue.destination as? MessageThreadDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let messageThread = messageThreadController.messageThreads[indexPath.row]
            detailVC.messageThread = messageThread
            detailVC.messageThreadController = messageThreadController
        }
    }
    
    var messageThreadController: MessageThreadController = MessageThreadController()
    
    @IBOutlet weak var threadTextField: UITextField!
    

}
