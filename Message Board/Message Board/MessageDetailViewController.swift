//
//  MessageDetailViewController.swift
//  Message Board
//
//  Created by Julian A. Fordyce on 1/23/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
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
    @IBAction func send(_ sender: UIBarButtonItem) {
    }
    
    
    // MARK - : Properties
    @IBOutlet weak var detailTextField: UITextField!
    
    @IBOutlet weak var detailTextView: UITextView!
    
}
