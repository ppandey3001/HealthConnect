//
//  CostListTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 08/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class CostListTableCell: HPTableViewCell {
    
    @IBOutlet var practioner_label : UILabel!
    @IBOutlet var specialist_label : UILabel!
    @IBOutlet var radius_label : UILabel!
    @IBOutlet var address_label : UILabel!
    
}

extension CostListTableCell {
    
    func configureCostListCell(item : HPCostEstimatorList) {
        
        practioner_label.text = item.practionter
        specialist_label.text = item.speciality
        radius_label.text = item.radius
        address_label.text = item.address
    }
}

