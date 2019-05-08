//
//  MessageThreadTableViewController.swift
//  MessageBoardHW
//
//  Created by Michael Flowers on 5/8/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageThreadTableViewController: UITableViewController {
    let mtc = MessageThreadController()
    

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionTextField(_ sender: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        mtc.createMessageThread(with: text) { (error) in
            if let error = error {
                print("Error calling the create message thread in the message thread table view controller: \(error.localizedDescription)")
                return
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let messageThread = mtc.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            guard let destinationVC = segue.destination as? MessageThreadDetailTableViewController, let index = tableView.indexPathForSelectedRow else { return }
            let messageThreadToPass = mtc.messageThreads[index.row]
            print("this is the messageThread to pass to the detail tableViewcontroller: \(messageThreadToPass)")
            destinationVC.mt = messageThreadToPass
            destinationVC.mtc = mtc
        }
    }

}
