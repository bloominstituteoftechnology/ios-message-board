//
//  MessageThreadsTableViewController.swift
//  ios-message-board
//
//  Created by De MicheliStefano on 08.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    
    @IBAction func create(_ sender: Any) {
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBOutlet weak var threadTextField: UITextField!
    

}
