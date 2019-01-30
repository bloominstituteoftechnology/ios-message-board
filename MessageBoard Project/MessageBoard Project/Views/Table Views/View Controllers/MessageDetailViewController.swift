//
//  MessageDetailViewController.swift
//  MessageBoard Project
//
//  Created by Michael Flowers on 1/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    var messageThread: MessageThread?
    var mtc: MessageThreadController?
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendMessage(_ sender: UIBarButtonItem) {
        guard let text = textField.text, !text.isEmpty,
            let body = textView.text, !body.isEmpty,
            let messageThread = messageThread else { return }
        
            mtc?.createMessage(with: messageThread, text: body, sender: text, completion: { (error) in
            if let error = error {
                print("Error in the send message function in detailViewController: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}
