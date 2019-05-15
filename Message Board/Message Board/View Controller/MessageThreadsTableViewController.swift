//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Hayden Hastings on 5/15/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        let message = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = message.title
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMessageBoard" {
            guard let messageTVC = segue.destination as? MessageThreadDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            messageTVC.messageThread = messageThreadController.messageThreads[indexPath.row]
            messageTVC.messageThreadController = messageThreadController
        }
    }
    
    @IBAction func messageAction(_ sender: Any) {
        guard let text = messageTextField.text else { return }
        messageTextField.text = ""
        messageThreadController.createMessageThread(with: text) { (error) in
            
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var messageTextField: UITextField!
    
    let messageThreadController = MessageThreadController()
    
}
