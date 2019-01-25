//
//  MessageThreadDetailTableViewController.swift
//  iOS Message Board
//
//  Created by Jaspal on 1/23/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    // MARK: - Properties
    let reuseIdentifier = "MessageDetailCell"
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title = to the `messageThread` object
        navigationItem.title = messageThread?.title

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let messageCount = messageThread?.messages.count else { return 0 }
        return messageCount
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let messageDetails = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = messageDetails?.text
        
        cell.detailTextLabel?.text = messageDetails?.sender

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == segueIdentifierDTVCtoDVC {
            
            guard let destination = segue.destination as? MessageDetailViewController else { return }
            
            // Pass the selected object to the new view controller.
            destination.messageThreadController = messageThreadController
            
            destination.messageThread = messageThread
        }
    }
    
    let segueIdentifierDTVCtoDVC = "ThreadtoMessage"

}
