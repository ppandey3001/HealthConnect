//
//  ForgotPasswordViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 29/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: HPViewController {

    @IBOutlet var textField_email: UITextField!
    @IBOutlet var button_send: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }

    
    @IBAction func buttonAction_back(_ sender: UIButton) {
        
        container()?.showBrandingBar(false)
        pop()
    }
    
    @IBAction func buttonAction_send(_ sender: Any) {
        container()?.showBrandingBar(false)
        pop()
    }
    
}

//MARK: Private methods
private extension ForgotPasswordViewController {
    
    private func setupController() {

    }
}

