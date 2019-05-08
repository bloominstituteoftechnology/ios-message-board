//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Lisa Sampson on 5/8/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    // MARK: - Properties and Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    let messageThreadController = MessageThreadController()
    
    // MARK: - View Loading Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - IBActions
    
    @IBAction func messageThreadCreated(_ sender: Any) {
        
        guard let title = textField.text else { return }
        
        messageThreadController.createMessageThread(title: title) { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        textField.text = ""
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)

        let message = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = message.title

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MessageThreadDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let detailTVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            let message = messageThreadController.messageThreads[indexPath.row]
            detailTVC.messageThread = message
            detailTVC.messageThreadController = messageThreadController
        }
    }
}
