//
//  ViewController.swift
//  Message Board
//
//  Created by Simon Elhoej Steinmejer on 08/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class MessageBoardTableViewController: UITableViewController
{
    let cellId = "messageBoardCell"
    let messageThreadController = MessageThreadController()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        messageThreadController.fetchMessageThreads {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNavBar()
    }

    private func setupNavBar()
    {
        title = "Message Board"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(handleAddMessageThread))
    }
    
    @objc private func handleAddMessageThread()
    {
        let alert = UIAlertController(title: "Enter the title of the new message thread", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            
            guard let title = alert.textFields![0].text else { return }
            
            self.messageThreadController.createMessageThread(title: title, completion: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let messageDetailTableViewController = MessageDetailTableViewController(style: .plain)
        messageDetailTableViewController.messageThreadController = messageThreadController
        let messageThread = messageThreadController.messageThreads[indexPath.row]
        messageDetailTableViewController.messageThread = messageThread
        navigationController?.pushViewController(messageDetailTableViewController, animated: true)
    }

}













