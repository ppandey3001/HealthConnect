//
//  AllergyTableViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit
import Foundation


class AllergyTableViewCell: HPTableViewCell {
    
    @IBOutlet var title_label : UILabel!

}

extension AllergyTableViewCell {
    
    func configureAllergyCell(item: HPAllergiesItem) {
        
        title_label.text = item.allergy
    }
    
    func configureConditionCareCell(item: HPConditionItem) {
        
        title_label.text = item.condition
    }
    
    func configureStaticAllergyCell(item: HPAllergyItem) {
        let attributes = item.type.attributes()
        title_label.text = attributes.title
    }
    
    func configureStaticConditionCareCell(item: HPHistoryConditionItem) {
        
        let attributes = item.type.attributes()
        title_label.text = attributes.condition
        
    }
    
}
