//
//  RegistrationViewController.swift
//  HealthProfiler
//

import UIKit

class RegistrationViewController: HPViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        container()?.showBrandingBar(false)
        pop()
    }
}

//MARK: Private methods
private extension RegistrationViewController {
    
    private func setupController() {
        
    }
}


//MARK: Public methods
extension RegistrationViewController {
    
}

