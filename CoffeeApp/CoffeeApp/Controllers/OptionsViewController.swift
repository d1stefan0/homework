import UIKit

class OptionsViewController: UIViewController {
    
    @IBOutlet weak var sugarBarSlider: UISlider!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var ownCup: UISwitch!
    
    var coffee: CoffeeType!
    var size: Volume!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sugarLabel.text = "\(Int(sugarBarSlider.value))g"
        ownCup.addTarget(self, action: #selector(ownCupSwitch(_:)), for: .valueChanged)
        
    }
    
    @IBAction func sugarBarSliderAction(_ sender: UISlider) {
        sugarLabel.text = "\(Int(sender.value))g"
    }
    
    
    @objc private func ownCupSwitch(_ sender: UISwitch) {
        //       label.text = "Switch \(sender.isOn)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! NamesTableViewController).coffee = coffee
        (segue.destination as! NamesTableViewController).size = size
        (segue.destination as! NamesTableViewController).sugar = Int(sugarBarSlider.value)
        (segue.destination as! NamesTableViewController).ownCup = ownCup.isOn
    }
    
}
