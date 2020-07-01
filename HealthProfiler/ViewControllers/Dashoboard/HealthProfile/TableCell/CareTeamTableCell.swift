//
//  CareTeamTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 25/06/20.
//  Copyright © 2020 UHG. All rights reserved.
//

import UIKit

class CareTeamTableCell: HPTableViewCell {
    
    @IBOutlet var name_label: UILabel!
    @IBOutlet var specialist_label: UILabel!
    
}

extension CareTeamTableCell {
    
    func configureCareTeam(item : HPCareTeamItem) {
        
        name_label.text = item.practitioner
        specialist_label.text = item.speciality
    }
    
    func configureCernerCareTeamCell(item: HPCernerCareTeamItem) {
        
        let attributes = item.type.attributes()
        name_label.text = attributes.name
        specialist_label.text = attributes.speciality
    }
}
