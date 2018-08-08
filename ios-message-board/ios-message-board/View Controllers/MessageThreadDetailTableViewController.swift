//
//  MessageThreadDetailTableViewController.swift
//  ios-message-board
//
//  Created by Conner on 8/8/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class MessageThreadDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
