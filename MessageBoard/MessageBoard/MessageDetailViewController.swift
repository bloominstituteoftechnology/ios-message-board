//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Yvette Zhukovsky on 10/23/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func send(_ sender: Any) {
        guard let msgThread = messageThread else {return}
        let snder = enterName?.text
        let msg = enterMessage?.text
        
        
        
        messageThreadController?.createMessage(for: msgThread, text: msg!, sender: snder!, completion: { (error) in
            if let error = error {
                NSLog("Error saving new message thread: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @IBOutlet weak var enterName: UITextField!
    
    @IBOutlet weak var enterMessage: UITextView!
    
}
