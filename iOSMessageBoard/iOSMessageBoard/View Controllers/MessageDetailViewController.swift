//
//  MessageDetailViewController.swift
//  iOSMessageBoard
//
//  Created by Jonathan Ferrer on 5/15/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Message"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard let nameText = nameTextField.text, !nameText.isEmpty,
            let messageText = messageTextView.text, !messageText.isEmpty,
            let messageThread = messageThread else { return }
        messageThreadController?.createMessage(messageThread: messageThread, text: messageText, sender: nameText, completion: { (error) in
            if let error = error {
                print("error creating message: \(error)")
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })

    }
    
}
