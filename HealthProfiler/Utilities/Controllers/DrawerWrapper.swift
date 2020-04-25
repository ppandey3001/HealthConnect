//
//  DrawerWrapperController.swift
//  HealthProfiler
//

import UIKit
import DrawerMenu

class DrawerWrapper: UIViewController {
    
    var leftVC: UIViewController!
    var centerVC: UIViewController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(_ centerVC: UIViewController, leftVC: UIViewController) {
        
        super.init(nibName: nil, bundle: nil)
        self.centerVC = centerVC
        self.leftVC = leftVC
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawer = DrawerMenu(center: centerVC, left: leftVC)
        drawer.style = Overlay()
        drawer.panGestureType = .none
        
        addChild(drawer)
        view.addSubview(drawer.view)
        drawer.didMove(toParent: self)
    }
}
