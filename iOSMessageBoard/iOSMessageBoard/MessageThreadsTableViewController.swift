//
//  MessageThreadsTableViewController.swift
//  iOSMessageBoard
//
//  Created by Jonathan Ferrer on 5/15/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    var messageThreadController: MessageThreadController = MessageThreadController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageBoard" {
            guard let destinationVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            destinationVC.messageThreadcontroller = messageThreadController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.messageThread = messageThreadController.messageThreads[indexPath.row]
        }
    }




    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBoardCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title

        return cell
    }


    @IBAction func textFieldAction(_ sender: Any) {
        guard let titleText = textField.text else { return }
        messageThreadController.createMessagethread(title: titleText) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    

}
