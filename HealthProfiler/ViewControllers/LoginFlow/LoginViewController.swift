//
//  LoginViewController.swift
//  HealthProfiler
//

import UIKit

class LoginViewController: HPViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        container()?.showBrandingBar(true)
        push(controller: HomeViewController.nibInstance())
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        
        container()?.showBrandingBar(true)
        push(controller: RegistrationViewController.nibInstance())
    }
    
}

//MARK: Private methods
private extension LoginViewController {
    
    private func setupController() {
        container()?.showBrandingBar(false)
        
    }
}


//MARK: Public methods
extension LoginViewController {
    
}
