//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Jeremy Taylor on 8/8/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func send(_ sender: Any) {
        guard let name = nameTextField.text,
           let text = messageTextView.text,
            let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(in: messageThread, withText: text, andSender: name, completion: { (error) in
            if let error = error {
                NSLog("Error creating a new message: \(error)")
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
