//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Julian A. Fordyce on 1/23/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    let messageThreadController = MessageThreadController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let messageThreads = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThreads.title
        return cell
    }
    



    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTableView" {
            guard let messageVC = segue.destination as? MessageThreadDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            messageVC.messageThread = messageThreadController.messageThreads[indexPath.row]
            messageVC.messageThreadController = messageThreadController
        }
    }
    
    
    @IBAction func search(_ sender: Any) {
        guard let text = textField.text, !text.isEmpty else { return }
        
        messageThreadController.createMessageThread(title: text) { (error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.textField.text = nil
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Properties
    
    @IBOutlet weak var textField: UITextField!
}
