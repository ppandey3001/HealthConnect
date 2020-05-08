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
    
}

extension CareTeamCollectionCell {
    
    func configureCareCell(item: HPCareTeamItem) {
        
        doctorName_label.text = item.practitioner
        speciality_label.text = item.speciality
    }
}
