import UIKit

private let refreshControl = UIRefreshControl()

class MessageThreadsTableViewController: UITableViewController {
    let messageThreadController = MessageThreadController()
    
    @objc func fetch() {
        messageThreadController.fetchMessageThreads { (success) in
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    override func viewDidLoad() {
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = UIColor(red: 1.00, green: 0.21, blue: 0.55, alpha: 1.0) //pink
        refreshControl.addTarget(self, action: #selector(fetch), for: .valueChanged)
        refreshControl.endRefreshing()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageThreadController.fetchMessageThreads { (success) in
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    @IBAction func CreateANewThread(_ sender: Any) {
        guard let title = messageThreadTextField.text else { return }
        
        messageThreadController.createMessageThread(title: title) { (success) in
            DispatchQueue.main.async { self.tableView.reloadData()}
        }
        
        messageThreadTextField.text = ""
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreadController.messageThreads.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageThreadCell", for: indexPath)
        
        let message = messageThreadController.messageThreads[indexPath.row]
        cell.textLabel?.text = message.title
        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessageThreads" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let detailTVC = segue.destination as? MessageThreadDetailTableViewController else { return }
            let message = messageThreadController.messageThreads[indexPath.row]
            detailTVC.messageThread = message
            detailTVC.messageThreadController = messageThreadController
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    @IBOutlet weak var messageThreadTextField: UITextField!
    
    
}
