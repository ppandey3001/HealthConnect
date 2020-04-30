//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit

class HomeViewController: HPViewController {
    
    @IBOutlet var view_welcomeMessageContainer: UIView!
    @IBOutlet var label_welcomeMessageTitle: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func buttonAction_getStarted(_ sender: UIButton) {
        
        view_welcomeMessageContainer.isHidden = true
        tabBarController?.selectedIndex = HPTabType.manageConnections.tabIndex
    }
}

//MARK: Private methods
private extension HomeViewController {
    
    private func setupController() {
        
        label_welcomeMessageTitle.text = "Welcome John Doe!"
    }
}


//MARK: Public methods
extension HomeViewController {
    
}

