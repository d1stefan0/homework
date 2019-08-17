import UIKit

class BillTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var ownCupLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var myCoffee: Coffee!
    var coffee: CoffeeType!
    var size: Volume!
    var sugar: Int!
    var ownCup: Bool!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        coffeeLabel.text = coffee.rawValue
        sizeLabel.text = size.rawValue
        sugarLabel.text = "\(sugar ?? 0)g"
        ownCupLabel.text = ownCup ? "Yes" : "No"
        priceLabel.text = "$\(coffeePrice(coffee: coffee, size: size, sugar: sugar, ownCup: ownCup))"
    }
    
    func coffeePrice (coffee: CoffeeType, size: Volume, sugar: Int, ownCup: Bool) -> Double {
        var price = 0.0
        switch coffee {
        case .americano: price = 3
        case .cappuccino: price = 4
        case .espresso: price = 2.5
        case .flatWhite: price = 5
        case .irishCoffee: price = 5
        case .latte: price = 4.5
        case .macchiato: price = 4.5
        case .mocca: price = 4.5
        }
        
        if size == .big {
            price += 1
        } else if size == .small {
            price -= 1
        }
        
        price += Double(sugar) / 100
        
        if ownCup {
            price -= 0.5
            print("own Cup")
        }
        
        return price
    }
    
    @IBAction func confirmCoffee(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: "pay and take your coffee", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "OK", style: .default, handler: {
            alertAction in
            self.performSegue(withIdentifier: "lastVC", sender: self)
        })
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! LastImageViewController).name = name
    }
    
}
