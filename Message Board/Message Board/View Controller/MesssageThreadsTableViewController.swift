//
//  MesssageThreadsTableViewController.swift
//  Message Board
//
//  Created by Iyin Raphael on 8/15/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class MesssageThreadsTableViewController: UITableViewController {

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


  

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    @IBAction func textFieldAction(_ sender: Any) {
    }
    @IBOutlet weak var textField: UITextField!
    

}
