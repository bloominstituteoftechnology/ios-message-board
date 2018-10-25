import UIKit

class MessageThreadsTableViewController: UITableViewController {
    
    var messageThreadController: MessageThreadController = MessageThreadController()
    
    @IBOutlet weak var messageThreadOutlet: UITextField!
    @IBAction func messageThreadTextField(_ sender: Any) {
        guard let threadTitle = messageThreadOutlet.text else { return }
        
        messageThreadController.createMessageThread(title: threadTitle) { (success) in
            DispatchQueue.main.async {self.tableView.reloadData()}
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }
    
    let reuseIdentifier = "cell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let thread = messageThreadController.messageThreads[indexPath.row]
        
        cell.textLabel?.text = thread.title
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? MessageThreadDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
        
        destination.messageThreadController = messageThreadController
        destination.messageThread = messageThreadController.messageThreads[indexPath.row]
        
    }
    
    
}
