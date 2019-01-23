//
//  MessageDetailViewController.swift
//  MessageBoard
//
//  Created by Jocelyn Stuart on 1/23/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

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
    
    
    @IBAction func sendButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var messageTextView: UITextView!
    
    
    

}
