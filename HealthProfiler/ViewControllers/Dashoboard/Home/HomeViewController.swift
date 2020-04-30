//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit

class HomeViewController: HPViewController {
    
    @IBOutlet private var welcome_view : UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func getStartedAction(_ sender: UIButton) {
        
        welcome_view.isHidden = true
        tabBarController?.selectedIndex = 3
    }
}

//MARK: Private methods
private extension HomeViewController {
    
    private func setupController() {
        
    }
}


//MARK: Public methods
extension HomeViewController {
    
}

