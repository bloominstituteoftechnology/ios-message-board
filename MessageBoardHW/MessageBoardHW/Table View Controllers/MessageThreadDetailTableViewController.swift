//
//  MessageThreadDetailTableViewController.swift
//  MessageBoardHW
//
//  Created by Michael Flowers on 5/8/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {
    
    var mt: MessageThread?
    var mtc: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = mt?.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mt?.messages.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath)

        // Configure the cell...
        let messages = mt?.messages[indexPath.row]
        cell.textLabel?.text = messages?.text
        cell.detailTextLabel?.text = messages?.sender

        return cell
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            guard let destinationVC = segue.destination as? MessageDetailViewController, let messageThread = mt, let messagethreadcontroller = mtc  else { return }
            print("this is messageThread: \(messageThread)")
            destinationVC.mt = messageThread
            destinationVC.mtc = messagethreadcontroller
        }
    }
}
