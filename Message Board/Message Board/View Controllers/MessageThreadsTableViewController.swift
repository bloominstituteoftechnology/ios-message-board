//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Mitchell Budge on 5/15/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    let messageThreadController: MessageThreadController = MessageThreadController()

    override func viewDidLoad() {
        super.viewDidLoad()
    } // end of view did load
    
    override func viewWillAppear(_ animated: Bool) {
        messageThreadController.fetchMessageThreads { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    } // end of view will appear
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func messageTextFieldEdited(_ sender: Any) {
        guard let text = messageTextField.text, text != "" else { return }
        messageThreadController.createMessageThread(with: text) { (error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    } // end of text field action

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    } // end of number of rows

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let messageThreads = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThreads.title
        return cell
    } // end of cell for row at
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let messageTDVC = segue.destination as? MessageThreadDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            messageTDVC.messageThread = messageThreadController.messageThreads[indexPath.row]
            messageTDVC.messageThreadController = messageThreadController
        }
    } // end of segue
}
