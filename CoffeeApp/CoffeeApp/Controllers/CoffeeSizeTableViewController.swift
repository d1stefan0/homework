import UIKit

class CoffeeSizeTableViewController: UITableViewController {

    var coffee: CoffeeType!
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Volume.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = Volume.allCases[indexPath.row].rawValue
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let size: Volume
        size = Volume.allCases[indexPath.row]
        
        (segue.destination as! OptionsViewController).coffee = coffee
        (segue.destination as! OptionsViewController).size = size
    }
    
}
