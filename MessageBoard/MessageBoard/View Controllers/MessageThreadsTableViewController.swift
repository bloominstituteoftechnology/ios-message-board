//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Christopher Aronson on 5/8/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    // MARK: - Properties
    var messageThreadControler = MessageThreadController()
    
    // MARK: - IBOutlet
    @IBOutlet weak var messagesThreadTextField: UITextField!
    
    
    // MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MessageThreadsTableViewController viewDidLoad()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MessageThreadsTableViewController viewWillAppear()")
        messageThreadControler.fetchMessageThreads { (error) in
            if let error = error {
                print(error)
                return
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("MessageThreadsTableViewController numberOfRows")
        // #warning Incomplete implementation, return the number of rows
        return messageThreadControler.messageThread.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("MessageThreadsTableViewController cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)

        let message = messageThreadControler.messageThread[indexPath.row]
        cell.textLabel?.text = message.title

        return cell
    }

    // MARK: - prepare(for segue )
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageThreadDetail" {
            let detinationVC: MessageThreadDetailTableViewController = segue.destination as! MessageThreadDetailTableViewController
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            detinationVC.messageThread = messageThreadControler.messageThread[index]
            detinationVC.messageThreadController = messageThreadControler
        }
    }
 
    
    // MARK: - IBActions
    @IBAction func exitMessageThreadTextField(_ sender: Any) {
        guard let text = messagesThreadTextField.text else { return }
        
        messageThreadControler.createMessageThread(title: text) { (error) in
            if let error = error {
                print(error)
                return
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        messagesThreadTextField.text = ""
    }
    
    
    
}
