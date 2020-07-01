//
//  HistoryConditionTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/07/20.
//  Copyright © 2020 UHG. All rights reserved.
//

import UIKit

class HistoryConditionTableCell: HPTableViewCell {
    
    @IBOutlet var title_label : UILabel!
    @IBOutlet var hospitalLogo_imageView : UIImageView!
    @IBOutlet var visitedOn_label : UILabel!
    @IBOutlet var logo_imageView : UIImageView!


}

extension HistoryConditionTableCell {
    
    func configureConditionCell(item: HPHistoryConditionItem){
        
        let attributes = item.type.attributes()

        title_label.text = attributes.condition
        hospitalLogo_imageView.image = UIImage(named: attributes.hospitalLogo)
        visitedOn_label.text = "Visited On : " + attributes.visitedOn
        logo_imageView.image = UIImage(named: attributes.logo)
    }
    
    func configureAllergyCell(item: HPAllergiesItem){
        
        title_label.text = item.allergy
        hospitalLogo_imageView.image = UIImage(named: "southwestmedical")
        visitedOn_label.text = "Visited On : " + "Jun 27, 2020"
        logo_imageView.image = UIImage(named: "Allscripts")

    }
}
