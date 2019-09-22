import UIKit

class ViewController: UIViewController {

    private var number = 65
    private struct numbers {
        var a = 15
        var b = 5
    }
    private let serialQueue = DispatchQueue(label: "serQ")
    private let concurrentQueue = DispatchQueue(label: "conQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serialQueue.async {
            self.number += 10   // 75
            self.number -= 50   // 25
            self.number *= 2    // 50
        }
        
        print("First task - \(number)")
        
        var c = numbers()
        concurrentQueue.async {
            c.a -= c.b  // 10
            c.b += c.a  // 15
            c.a *= 2    // 20
            c.b *= 2    // 30
        }
        concurrentQueue.sync {
            print("Second task - \(c.a + c.b)")     // 50
        }
        
    }

}
