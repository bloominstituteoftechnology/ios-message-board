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
