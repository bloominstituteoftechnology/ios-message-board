//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Jeffrey Carpenter on 5/8/19.
//  Copyright © 2019 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    let messageThreadController = MessageThreadController()

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        print("saveButtonTapped")
        self.view.endEditing(true)
        
        guard let text = textField.text else { return }
        
        messageThreadController.createMessageThread(title: text) { error in
            
            if let error = error {
                print(error.localizedDescription)
                return
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowThreadDetail" {
            
            guard let destinationVC = segue.destination as? MessageThreadDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow
            else { return }
            
            let messageThread = messageThreadController.messageThreads[indexPath.row]
            destinationVC.messageThread = messageThread
            
            destinationVC.messageThreadController = messageThreadController
        }
    }
}
