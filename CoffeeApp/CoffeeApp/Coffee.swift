import Foundation

enum CoffeeType: String, CaseIterable {
    case latte
    case cappuccino
    case espresso
    case americano
    case macchiato
    case mocca
    case flatWhite
    case irishCoffee
}

enum Volume: String, CaseIterable {
    case small
    case medium
    case big
}

class Coffee {
    var coffeeType: CoffeeType
    var volume: Volume
    var sugar: Int
    var isOwnCup: Bool
    var price: Double
    
    init(coffeeType: CoffeeType, volume: Volume, sugar: Int, isOwnCup: Bool, price: Double) {
        self.coffeeType = coffeeType
        self.volume = volume
        self.sugar = sugar
        self.isOwnCup = isOwnCup
        self.price = price
    }
}
