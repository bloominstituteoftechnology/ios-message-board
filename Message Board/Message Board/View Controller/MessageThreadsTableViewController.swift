//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Ilgar Ilyasov on 9/19/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var messageThreadController = MessageThreadController()
    var refresher: UIRefreshControl!
    
    // MAR: - Outlets
    
    @IBOutlet weak var messageTextField: UITextField!
    
    
    // MARK: - App lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.tintColor = UIColor(red: 1.00, green: 0.21, blue: 0.55, alpha: 1.00)
        refresher.addTarget(self, action: #selector(messageTextFieldAction), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageThreadController.fetchMessageThreads { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func messageTextFieldAction(_ sender: Any) {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        
        messageThreadController.createMessageThread(title: text) { (_) in
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
        if segue.identifier == "MessageBoardCellSegue" {
            let destionationVC = segue.destination as! MessageThreadDetailTableViewController
            destionationVC.messageThreadController = messageThreadController
            
            guard let index = tableView.indexPathForSelectedRow else { return }
            destionationVC.messageThread = messageThreadController.messageThreads[index.row]
        }
    }
}
