//
//  PrivacyPolicyViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 27/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: HPViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
}

//MARK: Private methods
private extension PrivacyPolicyViewController {
    
    private func setupController() {
        container()?.showBrandingBar(true)
    }
}
