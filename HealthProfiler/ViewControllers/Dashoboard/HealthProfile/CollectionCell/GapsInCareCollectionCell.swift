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
        
        let attributes = item.type.attributes()
        
        coloredBg_view.backgroundColor = attributes.bgColor
        title_label.text = attributes.name
        
    }
    
    func configureAllergyCell(item: HPAllergiesItem) {
        
        let attributes = item.type.attributes()
        
        coloredBg_view.backgroundColor = attributes.bgColor
        title_label.text = attributes.name
        
    }
    func configureConditionCareCell(item: HPConditionItem) {
        
        let attributes = item.type.attributes()
        
        coloredBg_view.backgroundColor = attributes.bgColor
        title_label.text = attributes.name
        title_label.textColor = .orange
        
    }
}
