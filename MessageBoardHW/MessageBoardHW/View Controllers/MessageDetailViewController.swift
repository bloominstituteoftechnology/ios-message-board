//
//  MessageDetailViewController.swift
//  MessageBoardHW
//
//  Created by Michael Flowers on 5/8/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    var mt: MessageThread?
    var mtc: MessageThreadController?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mt?.title
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButton(_ sender: UIBarButtonItem) {
        print("send button hit")
        guard let text = textField.text, !text.isEmpty, let body = textView.text, !body.isEmpty, let mt = mt else { return }
        mtc?.createMessage(with: mt, text: text, sender: body, completion: { (error) in
            if let error = error {
                print("Error calling the create message function in the detail view controller: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}
