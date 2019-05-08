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
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadControler.messageThread.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)

        let message = messageThreadControler.messageThread[indexPath.row]
        cell.textLabel?.text = message.title

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
    }
}
