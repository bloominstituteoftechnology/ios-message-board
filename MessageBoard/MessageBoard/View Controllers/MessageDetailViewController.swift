//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Farhan on 9/12/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var messageField: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createMessage(_ sender: Any) {
        
        guard let messageThread = messageThread, let name = nameField.text, let messageText = messageField.text else {return}
        
        messageThreadController?.createMessage(messageThread: messageThread, text: messageText, sender: name, completion: { (_) in
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
