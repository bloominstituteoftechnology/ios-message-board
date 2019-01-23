//
//  MessageThreadsTableViewController.swift
//  MessageBoard Project
//
//  Created by Michael Flowers on 1/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    let mtc: MessageThreadController = MessageThreadController()
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mtc.fetchMessageThread { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    @IBAction func textFieldAction(_ sender: UITextField) { //need more explanation
        guard let text = textField.text, !text.isEmpty else { return }
        mtc.createMessageThread(with: text) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mtc.messageThreads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let messageThread = mtc.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        
        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "cellSegue" {
            guard let toDestinationVc = segue.destination as? MessageThreadDetailTableViewController, let index = tableView.indexPathForSelectedRow else { return }
            
            let messageThread = mtc.messageThreads[index.row]
            toDestinationVc.messageThread = messageThread
            toDestinationVc.mtc = mtc
        } else if segue.identifier == "addSegue" {
            guard let toDestinationVc = segue.destination as? MessageDetailViewController, let index = tableView.indexPathForSelectedRow else { return }
            
            let messageThread = mtc.messageThreads[index.row]
            toDestinationVc.messageThread = messageThread
            toDestinationVc.mtc = mtc
        }
    }
  

}
