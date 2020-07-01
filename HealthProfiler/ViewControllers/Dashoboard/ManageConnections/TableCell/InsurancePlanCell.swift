//
//  InsurancePlanCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class InsurancePlanCell: HPTableViewCell {
    
//    @IBOutlet var title_label : UILabel!
    @IBOutlet var icon_imageView : UIImageView!
    @IBOutlet var activeStatus_switch : UISwitch!
    @IBOutlet var refresh_Button : UIButton!
    @IBOutlet var bg_view : UIView!
    
    func registerCell() {
        
        bg_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        bg_view.layer.shadowOpacity = 1
        bg_view.layer.cornerRadius = 10.0
        bg_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        bg_view.layer.shadowRadius = 1
    }

}

//MARK: public methods
extension InsurancePlanCell {
    
    //configure cell for login items
    func configureInsuranceCell(item: HPConnectedInsuranceItem, index: Int) {
        
        let attributes = item.type.attributes()
        icon_imageView.image = UIImage(named: attributes.icon)
//        title_label.text = attributes.title
        activeStatus_switch.isSelected = true
        if item.type == .blueButton {
            activeStatus_switch.isSelected = !(HealthProfiler.shared.loggedInUser?.blueButtonConnected ?? false)
        }
    }
}
