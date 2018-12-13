//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Ivan Caldwell on 12/13/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    // Variables and Constants
    
    // Outlets and Actions
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBAction func send(_ sender: Any) {
    }
    
    
    // Functions
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
