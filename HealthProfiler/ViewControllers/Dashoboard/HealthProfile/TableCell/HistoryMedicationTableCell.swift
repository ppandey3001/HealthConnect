//
//  HistoryMedicationTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/07/20.
//  Copyright © 2020 UHG. All rights reserved.
//

import UIKit

class HistoryMedicationTableCell: HPTableViewCell {
    
    @IBOutlet var title_label : UILabel!
    @IBOutlet var dose_label : UILabel!

}
extension HistoryMedicationTableCell {
    func configureMedicationCell(item : HPMedicationItem) {
        
        title_label.text = item.medicine
        dose_label.text = item.dosage
    }
    
    func configureStaticMedicationCell(item : HPMedicationsItem) {
        
        let attributes = item.type.attributes()

        title_label.text = attributes.title
        dose_label.text = attributes.dose
    }
    
}
