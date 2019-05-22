//
//  MessageThreadsTableViewController.swift
//  MessageBoard
//
//  Created by Thomas Cacciatore on 5/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    
    @IBAction func textFieldAction(_ sender: Any) {
    }
    
    

    @IBOutlet weak var messageThreadTextField: UITextField!
    
}
