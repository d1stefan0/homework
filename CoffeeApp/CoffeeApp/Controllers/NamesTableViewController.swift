import UIKit

class NamesTableViewController: UITableViewController {

    var coffee: CoffeeType!
    var size: Volume!
    var sugar: Int!
    var ownCup: Bool!
    
    var names = ["Alessandra", "Eugenio", "Alex", "Claudio", "Joshua", "James", "Stephan", "Karry", "Bobby", "Mark-Andre", "Lionel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl

    }

    @objc func refreshAction() {
        names.shuffle()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = names[indexPath.row]

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let name: String
        name = names[indexPath.row]
        
        (segue.destination as! BillTableViewController).coffee = coffee
        (segue.destination as! BillTableViewController).size = size
        (segue.destination as! BillTableViewController).sugar = sugar
        (segue.destination as! BillTableViewController).ownCup = ownCup
        (segue.destination as! BillTableViewController).name = name
    }
    
}
