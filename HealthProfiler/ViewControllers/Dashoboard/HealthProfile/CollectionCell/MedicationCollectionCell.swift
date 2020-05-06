//
//  MedicationCollectionCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class MedicationCollectionCell: HPCollectionViewCell {
    
    @IBOutlet private var medicineName_label : UILabel!
    @IBOutlet private var dose_label : UILabel!
    @IBOutlet private var tillDate_label : UILabel!
    
}

extension MedicationCollectionCell {
    
    func configureMedicationCell(item: HPMedicationItem) {
        
        let attributes = item.type.attributes()
        medicineName_label.text = attributes.name
        dose_label.text = attributes.dose
        tillDate_label.text = attributes.tillDate
        
    }
}
