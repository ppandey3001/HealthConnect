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
     var dataSource_provider = [HPConnectedProviderItem]()


    override func viewDidLoad() {
        super.viewDidLoad()
        terms_view.isHidden = true


        // Do any additional setup after loading the view.
    }

    @IBAction func signInBUttonAction(_ sender: UIButton){
        terms_view.isHidden = false
        dataSource_provider[1].isConnected = true
    }
    
    @IBAction func acceptBUttonAction(_ sender: UIButton){
        pop()
    }

}
