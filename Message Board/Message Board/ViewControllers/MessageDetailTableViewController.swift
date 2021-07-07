//
//  MessageTableViewController.swift
//  Message Board
//
//  Created by Simon Elhoej Steinmejer on 08/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class MessageDetailTableViewController: UITableViewController
{
    let cellId = "messageCell"
    var messageThreadController: MessageThreadController?
    var messageThread: MessageThread?
    {
        didSet
        {
            title = messageThread?.title
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleCreateNewMessage))
    }
    
    @objc private func handleCreateNewMessage()
    {
        let createMessageViewController = CreateMessageViewController()
        createMessageViewController.messageThreadController = messageThreadController
        createMessageViewController.messageThread = self.messageThread
        navigationController?.pushViewController(createMessageViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let messages = messageThread?.messages else { return 0}
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageCell
        
        let message = messageThread?.messages[indexPath.row]
        
        cell.textLabel?.text = message?.text
        cell.detailTextLabel?.text = message?.sender
        
        return cell
    }
}










