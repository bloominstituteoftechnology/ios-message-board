//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Angel Buenrostro on 1/23/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    let messageThreadController: MessageThreadController = MessageThreadController()

    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func messageTextFieldAction(_ sender: UITextField) {
        guard let messageText = messageTextField.text else { return }
        messageThreadController.createMessageThread(title: messageText) { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
                print("Number of message threads: \(self.messageThreadController.messageThreads.count)") // Testing by Print
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageThreadController.fetchMessageThreads { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagecell", for: indexPath)
        let message = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = message.title

        return cell
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageSegue"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let message = messageThreadController.messageThreads[indexPath!.row]
            let detailVC = segue.destination as! MessageThreadDetailTableViewController
            detailVC.messageThreadController = messageThreadController
            detailVC.messageThread = message
        }
    }
  

}
