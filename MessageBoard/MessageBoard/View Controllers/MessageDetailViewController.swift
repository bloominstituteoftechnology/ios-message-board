//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Christopher Aronson on 5/8/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var messageBodyTextView: UITextView!
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MessageDetailiewController viewDidLoad()")
    }

    // MARK: - IBActions
    @IBAction func sendButtonTapped(_ sender: Any) {
        print("MessageDetailiewController sendButtonTapped()")
        guard let sender = nameTextFiled.text,
        let text = messageBodyTextView.text,
        let message = messageThread
        else { print("something didn't work"); return }
        
        messageThreadController?.createMessage(parentThread: message, text: text, sender: sender, completion: { (error) in
            
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        })
    }



}
