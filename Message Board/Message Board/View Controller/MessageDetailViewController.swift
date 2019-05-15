//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Hayden Hastings on 5/15/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text,
            let message = messageTextView.text,
        let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: message, sender: name, completion: { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        })
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
}
