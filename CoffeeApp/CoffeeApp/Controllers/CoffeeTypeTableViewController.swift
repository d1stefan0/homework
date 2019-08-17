import UIKit

class CoffeeTypeTableViewController: UITableViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoffeeType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = CoffeeType.allCases[indexPath.row].rawValue
        return cell
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let coffee: CoffeeType
        coffee = CoffeeType.allCases[indexPath.row]
        
        (segue.destination as! CoffeeSizeTableViewController).coffee = coffee
    }

}
