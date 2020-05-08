//
//  RecentVisitCollectionCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 07/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class RecentVisitCollectionCell: HPCollectionViewCell {
    
    @IBOutlet var practionerName_label : UILabel!
    @IBOutlet var date_label : UILabel!
    @IBOutlet var line_label : UILabel!
    
}

extension RecentVisitCollectionCell{
    
    func configureRecentVisitCell(item: HPRecentVisitItem) {
        
        practionerName_label.text = item.practitioner
        date_label.text = item.date
    }
}
