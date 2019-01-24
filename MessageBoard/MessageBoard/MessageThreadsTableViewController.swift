//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Jocelyn Stuart on 1/23/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    let messageThreadController = MessageThreadController()
    
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

       cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title
        

        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageDetail" {
            guard let messageDetailVC = segue.destination as? MessageThreadDetailTableViewController, let messageIndex = tableView.indexPathForSelectedRow?.row else { return }
            
            messageDetailVC.messageThreadController = messageThreadController
            messageDetailVC.messageThread = messageThreadController.messageThreads[messageIndex]
        }
    }
    
    
    @IBAction func textFieldTapped(_ sender: UITextField) {
        guard let text = textField.text else { return }
        
        messageThreadController.createMessageThread(withTitle: text) { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    

}
