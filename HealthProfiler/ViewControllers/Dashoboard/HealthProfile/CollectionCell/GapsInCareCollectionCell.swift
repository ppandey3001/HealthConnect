//
//  GapsInCareCollectionCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class GapsInCareCollectionCell: HPCollectionViewCell {
    
    @IBOutlet var coloredBg_view: UIView!
    @IBOutlet var title_label: UILabel!
    @IBOutlet var icon_imageView: UIImageView!
    
}

extension GapsInCareCollectionCell {
    func configureGapsInCareCell(item: HPGapsInCareItem) {
                
//        coloredBg_view.backgroundColor = attributes.bgColor
        title_label.text = item.gap
        
    }
    
    func configureAllergyCell(item: HPAllergiesItem) {
        
        coloredBg_view.backgroundColor = UIColor.colorFromRGB(236.0, 236.0, 236.0)
        title_label.text = item.allergy
        
    }
    
    func configureConditionCareCell(item: HPConditionItem) {
        
        coloredBg_view.backgroundColor = .clear
        title_label.text = item.condition
        title_label.textColor = .orange
        
    }
}
