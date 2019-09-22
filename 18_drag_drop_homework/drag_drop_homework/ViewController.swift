import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var draggingView: UIView?
    private var offset: CGPoint?
    private var viewTouchBegin: CGPoint?
    
    let defaultX: CGFloat = 150
    let defaultY: CGFloat = 150
    
    let firstView = UIView()
    let secondView = UIView()
    let dragView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isMultipleTouchEnabled = true
        
        firstView.backgroundColor = .black
        firstView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        self.view.addSubview(firstView)
        
        secondView.backgroundColor = .black
        secondView.frame = CGRect(x: 100, y: 400, width: 200, height: 200)
        self.view.addSubview(secondView)
        
        dragView.backgroundColor = .red
        dragView.frame = CGRect(x: defaultX, y: defaultY, width: 100, height: 100)
        self.view.addSubview(dragView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //        let point = touches.map { $0.location(in: self.greenView) }.randomElement()!
        let points = touches.map { $0.location(in: self.view) }
        let point = points.randomElement()!
        if let view = self.view.hitTest(point, with: event), view == dragView {
            draggingView = view
            self.view.bringSubviewToFront(view)
            offset = CGPoint(x: point.x - view.center.x, y: point.y - view.center.y)
            viewTouchBegin = CGPoint(x: draggingView!.center.x + offset!.x, y: draggingView!.center.y + offset!.y)
        }
        print("Touches begin: \(points)")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        let points = touches.map { $0.location(in: self.view) }
        let point = points.randomElement()!
        
        if let view = draggingView {
            view.center = CGPoint(x: point.x - offset!.x, y: point.y - offset!.y)
        }
        
        print("Touches moved: \(points)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let points = touches.map { $0.location(in: self.view) }
//        let point = points.randomElement()!
        
        if let dragView = draggingView {
            if !firstView.point(inside: touches.map { $0.location(in: firstView)}.randomElement()!, with: event)
                &&
                !secondView.point(inside: touches.map { $0.location(in: secondView)}.randomElement()!, with: event) {
                    dragView.center = CGPoint(x: viewTouchBegin!.x - offset!.x, y: viewTouchBegin!.y - offset!.y)
            }
        }
        
        print("Touches end: \(points)")
    }
    
}

