//
//  MessageThreadsTableViewController.swift
//  ios-message-board
//
//  Created by Conner on 8/8/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                NSLog("Cannot fetch message threads: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)
        cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowThreadSegue" {
            if let vc = segue.destination as? MessageThreadDetailTableViewController {
                vc.messageThreadController = messageThreadController
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    vc.messageThread = messageThreadController.messageThreads[indexPath.row]
                }
            }
        }
    }

    @IBAction func createThread(_ sender: Any) {
        if let text = textField.text {
            messageThreadController.createMessageThread(title: text) { (error) in

                if let error = error {
                    NSLog("Error creating a message thread: \(error)")
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Properties
    @IBOutlet var textField: UITextField!
    var messageThreadController: MessageThreadController = MessageThreadController()

}
