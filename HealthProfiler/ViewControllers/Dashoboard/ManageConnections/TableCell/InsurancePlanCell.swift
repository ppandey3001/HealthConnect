//
//  InsurancePlanCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class InsurancePlanCell: HPTableViewCell {
    
    @IBOutlet var title_label : UILabel!
    @IBOutlet var icon_imageView : UIImageView!
    @IBOutlet var activeStatus_Button : UIButton!
    @IBOutlet var refresh_Button : UIButton!

}

//MARK: public methods
extension InsurancePlanCell {
    
    //configure cell for login items
    func configureInsuranceCell(item: HPConnectedInsuranceItem, index: Int) {
        let status = UserDefaults.standard.bool(forKey: "isBlueButtonLogin")
        let attributes = item.type.attributes()
        icon_imageView.image = UIImage(named: attributes.icon)
        title_label.text = attributes.title
        if item.type == .blueButton {
            activeStatus_Button.isSelected = !status
        }
    }
}
