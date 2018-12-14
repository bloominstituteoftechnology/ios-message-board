//
//  MessageThreadsTableViewController.swift
//  ios-message-board
//
//  Created by Austin Cole on 12/13/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController, UITextFieldDelegate {
    
    let messageThreadController: MessageThreadController = MessageThreadController()
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageThreadController.fetchThreads { error in
            if let error = error{
                NSLog("Error with fetchThreads in MTTVC viewWillAppear: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Textfield action and method
    @IBAction func messageTextField(_ sender: Any) {
        guard let text = messageTextField.text else {return}
        
        messageThreadController.createMessageThread(title: text) { error in
            if let error = error{
                NSLog("Could not call creatMessageThread function: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    

   

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageBoardCell", for: indexPath)
        
        cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? MessageThreadDetailTableViewController
        let indexPath = tableView.indexPathForSelectedRow
        let messageThread = messageThreadController.messageThreads[(indexPath?.row)!]
        
        destination?.messageThreadController = messageThreadController
        destination?.messageThread = messageThread
    }
}
