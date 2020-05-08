//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit
import MultiSlider

class HomeViewController: HPViewController {
    
    @IBOutlet private var temp_label : UILabel!
    @IBOutlet private var heartRate_label : UILabel!
    @IBOutlet private var bp_label : UILabel!
    @IBOutlet private var bmi_label : UILabel!
    
    @IBOutlet var multiSlider: MultiSlider!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
        
        addDrawerButton()
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

