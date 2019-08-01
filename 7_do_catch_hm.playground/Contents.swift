import UIKit

enum autoErrors: Error {
    case blockAuto
    case notEnoughtGasoline(gasolineNeeded: Double)
    case lowEnergyAccumulator
    case doNotCloseTheDoor
    case notDriverIntoAuto
}

class MyAuto {
    let rashod = 0.1
    var gasoline: Double
    var isOpen: Bool
    var isDriverOnTheAuto: Bool
    var isEngineStarted: Bool
    var isAccumulatorGood: Bool
    
    init(gasoline: Double, isOpen: Bool = false, isDriverOnTheAuto: Bool = false, isAccumulatorGood: Bool = true, isEngineStarted: Bool = false) {
        self.gasoline = gasoline
        self.isOpen = isOpen
        self.isDriverOnTheAuto = isDriverOnTheAuto
        self.isEngineStarted = isEngineStarted
        self.isAccumulatorGood = isAccumulatorGood
    }
    
    func openTheCar () {
        isOpen = true
        print("машина открыта, можно садиться")
    }
    
    func seatOnTheCar () throws {
        guard isOpen == true else {
            throw autoErrors.blockAuto
        }
        isDriverOnTheAuto = true
        isOpen = false
    }
    
    func zapravka (litres: Double) {
        gasoline += litres
        print("теперь у нас \(gasoline) л")
    }
    
    func driveMyAuto (distance: Double) throws {
        guard isDriverOnTheAuto == true else {
            throw autoErrors.notDriverIntoAuto
        }
        
        guard isAccumulatorGood == true else {
            throw autoErrors.lowEnergyAccumulator
        }
        
        guard distance <= gasoline / rashod else {
            throw autoErrors.notEnoughtGasoline(gasolineNeeded: distance * rashod - gasoline)
        }
        
        gasoline -= distance * rashod
        print ("удачно пройдено еще \(distance) км, осталось \(gasoline) л бензина")
    }
    
}

let auto = MyAuto(gasoline: 20)

//------------------первый подход к машине-------------
do {
    try auto.seatOnTheCar()
} catch autoErrors.blockAuto {
    print("машина закрыта, сесть невозможно")
}

//--------------- вернулись за ключами, сели------------
auto.openTheCar()
try? auto.seatOnTheCar()

do {
    try auto.driveMyAuto(distance: 300)
} catch autoErrors.notDriverIntoAuto {
    print("водитель не готов")
} catch autoErrors.lowEnergyAccumulator {
    print("сел аккумулятор")
} catch autoErrors.notEnoughtGasoline(let gas) {
    print("нехватка топлива, необходимо еще заправиться на : \(gas) л")
}

//-------------------косяки с поездкой-------------
auto.isDriverOnTheAuto = false
do {
    try auto.driveMyAuto(distance: 300)
} catch autoErrors.notDriverIntoAuto {
    print("водитель отсутсвует")
} catch autoErrors.lowEnergyAccumulator {
    print("сел аккумулятор")
} catch autoErrors.notEnoughtGasoline(let gas) {
    print("нехватка топлива, необходимо еще заправиться на : \(gas) л")
}

auto.isDriverOnTheAuto = true
auto.isAccumulatorGood = false
do {
    try auto.driveMyAuto(distance: 300)
} catch autoErrors.notDriverIntoAuto {
    print("водитель отсутсвует")
} catch autoErrors.lowEnergyAccumulator {
    print("сел аккумулятор")
} catch autoErrors.notEnoughtGasoline(let gas) {
    print("нехватка топлива, необходимо еще заправиться на : \(gas) л")
}

//---------------заменили аккум и через заправку в путь----------------
auto.isAccumulatorGood = true
auto.zapravka(litres: 15)
do {
    try auto.driveMyAuto(distance: 300)
} catch autoErrors.notDriverIntoAuto {
    print("водитель отсутсвует")
} catch autoErrors.lowEnergyAccumulator {
    print("сел аккумулятор")
} catch autoErrors.notEnoughtGasoline(let gas) {
    print("нехватка топлива, необходимо еще заправиться на : \(gas) л")
}
