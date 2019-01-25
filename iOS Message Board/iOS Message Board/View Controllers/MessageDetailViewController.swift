//
//  MessageDetailViewController.swift
//  iOS Message Board
//
//  Created by Jaspal on 1/23/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    // MARK: - Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let messageThread = messageThread,
            let message = textView.text,
            let sender = textField.text else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: message, sender: sender, completion: { (error) in
            if let error = error {
                print(error)
                return
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
