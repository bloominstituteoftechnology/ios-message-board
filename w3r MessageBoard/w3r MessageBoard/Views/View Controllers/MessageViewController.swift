//
//  MessageViewController.swift
//  w3r MessageBoard
//
//  Created by Michael Flowers on 1/30/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    var messageThread: MessageThread?
    var mtc: MessageThreadController?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendMessage(_ sender: UIBarButtonItem) {
        guard let title = textField.text, !title.isEmpty, let message = textView.text, !message.isEmpty, let messageThread = messageThread else { return }
        
        mtc?.createMessageThread(with: title, completion: { (error) in
            if let error = error {
                print("Error calling the create messageThread method: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }

}
