//
//  CareTeamCollectionCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class CareTeamCollectionCell: HPCollectionViewCell {
    
    @IBOutlet private var doctorName_label : UILabel!
    @IBOutlet private var speciality_label : UILabel!
    @IBOutlet private var bg_View : UIView!
    
    func registerCell(){
        bg_View.layer.cornerRadius = 10.0
        bg_View.layer.borderColor = UIColor.lightGray.cgColor
        bg_View.layer.borderWidth = 1.0
    }

}

extension CareTeamCollectionCell {
    
    func configureCareCell(item: HPCareTeamItem) {
        
        doctorName_label.text = item.practitioner
        speciality_label.text = item.speciality
    }
    
    
    func configureCernerCareCell(item: HPCernerCareTeamItem) {
        
        let attributes = item.type.attributes()
        doctorName_label.text = attributes.name
        speciality_label.text = attributes.speciality
    }
}
