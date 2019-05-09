//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by morse on 5/8/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentingViewController?.title = messageThread?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMessageThreads()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let messageThread = messageThread else { return 0 }
        return messageThread.messages.count
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThread.Message", for: indexPath)
        
        guard let messageThread = messageThread else { return cell }
        let message = messageThread.messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender

        return cell
    }
    
    func fetchMessageThreads() {
        messageThreadController?.fetchMessageThreads { error in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MessageDetailSegue" {
            guard let messageDetailVC = segue.destination as? MessageDetailViewController else { return }
            
            messageDetailVC.messageThreadController = messageThreadController
            messageDetailVC.messageThread = messageThread
        }
    }
}
