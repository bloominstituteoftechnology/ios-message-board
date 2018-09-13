//
//  MessageThreadDetailTableViewController.swift
//  MessageBoard
//
//  Created by Daniela Parra on 9/12/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = messageThread?.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThread?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        guard let messageThread = messageThread else { return UITableViewCell() }

        let message = messageThread.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender

        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
