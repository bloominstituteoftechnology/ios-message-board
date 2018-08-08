//
//  CreateMessageViewController.swift
//  Message Board
//
//  Created by Simon Elhoej Steinmejer on 08/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CreateMessageViewController: UIViewController
{
    var messageThreadController: MessageThreadController?
    var messageThread: MessageThread?
    
    let nameTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    let messageTextView: UITextView =
    {
        let tv = UITextView()
        tv.isEditable = true
        tv.layer.borderWidth = 0.5
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.masksToBounds = true
        tv.font = UIFont.systemFont(ofSize: 14)
        
        return tv
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupUI()
        
    }
    
    private func setupNavBar()
    {
        title = "New Message"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave()
    {
        guard let name = nameTextField.text, let text = messageTextView.text, let messageThread = messageThread else { return }
        messageThreadController?.createMessage(messageThread: messageThread, text: text, sender: name, completion: {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    private func setupUI()
    {
        view.addSubview(nameTextField)
        view.addSubview(messageTextView)
        
        nameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 30)
        
        messageTextView.anchor(top: nameTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, paddingBottom: 0, width: 0, height: 300)
    }
    
}















