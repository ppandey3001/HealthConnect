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
        
        medicineName_label.text = item.medicine
        dose_label.text = item.dosage
        //        tillDate_label.text = attributes.tillDate
    }
}
