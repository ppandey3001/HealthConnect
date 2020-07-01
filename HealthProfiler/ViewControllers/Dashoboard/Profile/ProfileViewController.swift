//
//  ProfileViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 18/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class ProfileViewController: HPViewController {
    
    @IBOutlet var name_Label : UILabel!
    @IBOutlet var dob_Label : UILabel!
    @IBOutlet var plan_Label : UILabel!
    @IBOutlet var mc_Label : UILabel!
    @IBOutlet var md_Label : UILabel!
    @IBOutlet var smoking_Label : UILabel!
    @IBOutlet var coverage_Label : UILabel!
    @IBOutlet var memberID_Label : UILabel!

    private let user = HealthProfiler.shared.loggedInUser

    override func viewDidLoad() {
        super.viewDidLoad()
          setUpController()
        // Do any additional setup after loading the view.
    }
    
    func layoutUIComponent() {
        
        mc_Label.layer.cornerRadius = 5.0
        mc_Label.layer.masksToBounds = true
        md_Label.layer.cornerRadius = 5.0
        md_Label.layer.masksToBounds = true
        smoking_Label.layer.cornerRadius = 5.0
        smoking_Label.layer.masksToBounds = true
        coverage_Label.layer.cornerRadius = 5.0
        coverage_Label.layer.masksToBounds = true
        
    }

}

extension ProfileViewController {
    
    func setUpController() {
        
        name_Label.text = user?.name
        dob_Label.text = "DOB: " + (user?.age ?? "")
        plan_Label.text = "Medicare Advantage Plan"
        memberID_Label.text = user?.memberID
        
        layoutUIComponent()
        self.navigationItem.title = "Profile"
    }
}
