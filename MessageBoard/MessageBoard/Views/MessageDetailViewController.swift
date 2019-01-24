//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Angel Buenrostro on 1/23/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func sendButton(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text else { return }
        guard let text = textView.text else { return }
        guard let messageThread = messageThread else { return }
        
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: name, completion: { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
