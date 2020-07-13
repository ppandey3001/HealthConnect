//
//  HealthProfilerCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HealthProfilerCell: HPTableViewCell {
    
    @IBOutlet var title_label : UILabel!
    @IBOutlet var subtitle_label : UILabel!
    
}

extension HealthProfilerCell {
    
    func configureMedicationCell(item: HPMedicationItem) {
        
        title_label.text = item.medicine
        subtitle_label.text = item.dosage
    }
    
    func configureGapsInCareCell(item: HPGapsInCareItem) {
        
        title_label.text = item.gap
        subtitle_label.text = item.date
    }
    
    func configureStaticMedicationCell(item: HPMedicationsItem) {

        let attributes = item.type.attributes()
        title_label.text = attributes.title
        subtitle_label.text = attributes.dose
    }
    
    func configureStaticGapsInCareCell(item: HPGapsItem) {
     
        let attributes = item.type.attributes()
        title_label.text = attributes.title
        subtitle_label.text = attributes.date
    }
}
