//
//  AllergyCollectionCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 11/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class AllergyCollectionCell: HPCollectionViewCell {
    
    @IBOutlet var title_Label : UILabel!
    @IBOutlet var bg_View : UIView!

}
extension AllergyCollectionCell {

        func configureAllergyCell(item: HPAllergiesItem) {
            
            title_Label.text = item.allergy
        }
    func configureConditionCareCell(item: HPConditionItem) {
            
        bg_View.backgroundColor = UIColor.colorFromRGB(245.0, 219.0, 201.0)
            title_Label.text = item.condition
        title_Label.textColor = UIColor.colorFromRGB(34.0, 82.0, 154.0)
}
        
}
