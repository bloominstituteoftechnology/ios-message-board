//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Welinkton on 9/20/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func sendMessageButton(_ sender: Any) {
        
    }
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
