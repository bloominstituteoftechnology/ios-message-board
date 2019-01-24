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
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)

        let messageThread = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = messageThread.title
        cell.detailTextLabel?.text = messageThread.identifier
        return cell
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//    }

}
