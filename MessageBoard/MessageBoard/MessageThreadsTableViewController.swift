//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Yvette Zhukovsky on 10/23/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    
   var messageThreadController: MessageThreadController = MessageThreadController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageThreadController.messageThreads.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

      cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecond" {
            guard let DVC = segue.destination as? MessageThreadDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let messagesThread = messageThreadController.messageThreads[indexPath.row]
            DVC.messageThread = messagesThread
            DVC.messageThreadController = messageThreadController
        }
    }
    
    
    
    

    
    @IBOutlet weak var enter: UITextField!
    
    @IBAction func enterText(_ sender: Any) {
        
         guard let title = enter.text else { return }
        messageThreadController.createMessageThread(title: title) { error in
            
            if let error = error {
                NSLog("Error\(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.enter.text = ""
            }
            
        }
    }
    

}
