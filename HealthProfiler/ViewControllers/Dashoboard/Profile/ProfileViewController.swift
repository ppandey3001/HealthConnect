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

}

extension ProfileViewController {
    
    func setUpController() {
        name_Label.text = user?.name
        dob_Label.text = (user?.age ?? "") + "Years"
        plan_Label.text = "Medicare Advantage Plan"
        memberID_Label.text = user?.memberID
    }
}
