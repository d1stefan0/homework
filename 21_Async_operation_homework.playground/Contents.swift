import UIKit

let queue = OperationQueue()

class AsyncOperation: Operation {
    enum State: String {
        case ready
        case executing
        case finished
        
        var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state: State = .ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isReady: Bool {
        return state == .ready && super.isReady
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished || isCancelled
    }
}

class SumAsyncOperation: AsyncOperation {
    let a: Int
    let b: Int
    var result: Int = 0
    
    init(_ a: Int, _ b: Int) {
        self.a = a
        self.b = b
    }
    
    override func main() {
        guard !isCancelled else {
            state = .finished
            print("Cancelled.")
            return
        }
        
        state = .executing
        DispatchQueue.global().async {
            
            for i in self.a...self.b {
                self.result += i
            }
            
            print("Finished. Sum from \(self.a) to \(self.b) is - \(self.result)")
            self.state = .finished
        }
    }
}

let sum1 = SumAsyncOperation(1, 100_000)
let sum2 = SumAsyncOperation(100_001, 200_000)
let sum3 = SumAsyncOperation(200_001, 300_000)
let sum4 = SumAsyncOperation(300_001, 400_000)
let sum5 = SumAsyncOperation(400_001, 500_000)
let sum6 = SumAsyncOperation(500_001, 600_000)
let sum7 = SumAsyncOperation(600_001, 700_000)
let sum8 = SumAsyncOperation(700_001, 800_000)
let sum9 = SumAsyncOperation(800_001, 900_000)
let sum10 = SumAsyncOperation(900_001, 1_000_000)

//sum11.addDependency(sum10)

queue.addOperation(sum1)
queue.addOperation(sum2)
queue.addOperation(sum3)
queue.addOperation(sum4)
queue.addOperation(sum5)
queue.addOperation(sum6)
queue.addOperation(sum7)
queue.addOperation(sum8)
queue.addOperation(sum9)
queue.addOperation(sum10)

queue.waitUntilAllOperationsAreFinished()

let sum11 = sum1.result + sum2.result + sum3.result + sum4.result + sum5.result + sum6.result + sum7.result + sum8.result + sum9.result + sum10.result

//while queue.operationCount > 0 {
//    print(queue.operations)
//    sleep(1)
//}
print("Completed")
print("Result: Sum from 1 to 1_000_000  = \(sum11)")
