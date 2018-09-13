//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Moin Uddin on 9/12/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let sender = messageTitle.text,
            let text = messageBody.text
            else { return }
        
        guard let messageThread = messageThread else {
            print("This didn't work")
            return}
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: sender, completion: { (_) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @IBOutlet weak var messageTitle: UITextField!
    @IBOutlet weak var messageBody: UITextView!
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
