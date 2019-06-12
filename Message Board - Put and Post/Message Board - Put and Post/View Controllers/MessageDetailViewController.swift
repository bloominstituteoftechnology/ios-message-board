//
//  MessageDetailViewController.swift
//  Message Board - Put and Post
//
//  Created by Nathan Hedgeman on 6/11/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    //MARK: Properties And Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func sendButtonTapped(_ sender: Any) {
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
