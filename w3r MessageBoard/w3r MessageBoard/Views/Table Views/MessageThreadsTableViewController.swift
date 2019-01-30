//
//  MessageThreadsTableViewController.swift
//  w3r MessageBoard
//
//  Created by Michael Flowers on 1/30/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    var mtc = MessageThreadController()

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mtc.fetchMessageThreads { (error) in
            if let error = error {
                print("Error calling the fetchMessageThreads \(error.localizedDescription)")
            }
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func actionTextField(_ sender: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        
        mtc.createMessageThread(with: text) { (error) in
            if let error = error {
                print("actionTextField error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mtc.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let message = mtc.messageThreads[indexPath.row]
        cell.textLabel?.text = message.title
        // Configure the cell...

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cellSegue" {
            guard let toDestinationVC = segue.destination as? MessageDetailTableViewController, let index = tableView.indexPathForSelectedRow else { return }
            let messageThreadToPass = mtc.messageThreads[index.row]
            toDestinationVC.mtc = mtc
            toDestinationVC.messageThread = messageThreadToPass
        }
    }

}
