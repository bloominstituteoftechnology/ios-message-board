//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class MessageThreadDetailTVC: UITableViewController {
    
    //MARK: Properties
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = messageThread?.title
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (messageThread?.messages.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        
        let messages = messageThread?.messages[indexPath.row]
        cell.textLabel?.text = messages?.text
        cell.detailTextLabel?.text = messages?.sender
        return cell

            }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MessageDetailVC else { return }
        
        destination.messageThread = messageThread
        destination.messageThreadController = messageThreadController
        
    }
}
