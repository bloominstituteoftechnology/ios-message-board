//  Copyright © 2019 Frulwinn. All rights

import UIKit

class MessageThreadsTVC: UITableViewController {

    // MARK: Properties
    var messageThreadController = MessageThreadController()
    
    @IBOutlet weak var testField: UITextField!
    
    @IBAction func textField(_ sender: Any) {
        guard let title = testField.text else { return }
        messageThreadController.createMessageThread(withTitle: title) { (error) in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.testField.text = ""

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageThreadController.messageThreads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) else { return }

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let destination = segue.destination as? MessageThreadDetailTVC else { return }
        
        destination.messageThread = messageThreadController.messageThreads[indexPath.row]

    }
}
