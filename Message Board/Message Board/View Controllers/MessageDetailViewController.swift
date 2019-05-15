//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Mitchell Budge on 5/15/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let sender = nameTextField.text, sender != "",
        let text = messageTextView.text, text != "",
            let messageThread = messageThread else { return }
        messageThreadController?.createMessage(newThread: messageThread, text: text, sender: sender, completion: { (error) in
            if let error = error {
                print(error)
                return
            }
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            }
        }
    )}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
