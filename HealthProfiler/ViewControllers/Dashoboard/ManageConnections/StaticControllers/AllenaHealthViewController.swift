//
//  AllenaHealthViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 11/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class AllenaHealthViewController: UIViewController {
    
    @IBOutlet private var terms_view: UIView!
    @IBOutlet private var name: UILabel!
    
    //private vars
    var dataSource_provider = [HPConnectedProviderItem]()
    private let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func signInBUttonAction(_ sender: UIButton) {
        
        terms_view.isHidden = false
        dataSource_provider[0].isConnected = true
        user?.isProviderConnected = true
    }
    
    @IBAction func acceptBUttonAction(_ sender: UIButton) {
        pop()
    }
}


//private mthods
extension AllenaHealthViewController {
    
    private func setupController() {
        
        terms_view.isHidden = true
        name.text = user?.name
    }
}
