//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Linh Bouniol on 8/8/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    // MARK: - Outlets/Actions
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var messageTextView: UITextView!
    
    @IBAction func send(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
