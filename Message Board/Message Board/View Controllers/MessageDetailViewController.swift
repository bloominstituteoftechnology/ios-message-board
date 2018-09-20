//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Madison Waters on 9/19/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBOutlet weak var messageSenderTextField: UITextField!
    @IBOutlet weak var messageBodyTextView: UITextView!
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
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
