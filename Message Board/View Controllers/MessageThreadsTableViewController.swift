//
//  MessageThreadsTableViewController.swift
//  Message Board
//
//  Created by Jason Modisett on 9/12/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

enum ReuseIdentifiers: String {
    case messageThreadCell = "ThreadCell"
    case messageCell = "MessageCell"
}

enum SegueIdentifiers: String {
    case toMessageThreadDetailsScene = "ShowMessageThreadDetails"
    case toMessageDetailsScene = "ShowMessageDetails"
    case toNewMessageScene = "ShowNewMessage"
}

class MessageThreadsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchThreads(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchThreads(self)
        self.tableView.reloadData()
    }
    
    @objc private func fetchThreads(_ sender: Any) {
        messageThreadController.fetchMessageThreads { (error) -> (Void) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.messageThreadCell.rawValue, for: indexPath)

        cell.textLabel?.text = messageThreadController.messageThreads[indexPath.row].title

        return cell
    }

    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.toMessageThreadDetailsScene.rawValue {
            guard let destVC = segue.destination as? MessageThreadDetailTableViewController,
                  let index = tableView.indexPathForSelectedRow?.row else { return }
            destVC.messageThreadController = messageThreadController
            destVC.messageThread = messageThreadController.messageThreads[index]
        }
    }
    
    
    // MARK:- IBActions
    @IBAction func textFieldAction(_ sender: UITextField) {
        guard let threadTitle = textField.text else { return }
        
        messageThreadController.createMessageThread(with: threadTitle) { (error) -> (Void) in
            self.fetchThreads(self)
        }
    }
    
    
    // MARK:- Properties
    let messageThreadController = MessageThreadController()
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var textField: UITextField!
    
}
