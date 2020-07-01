//
//  RecentCliamsListCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 04/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class RecentCliamsListCell: HPTableViewCell {
    
    @IBOutlet var doctorValue_label: UILabel!
    @IBOutlet var dateValue_label: UILabel!
    @IBOutlet var billAmtValue_label: UILabel!
    @IBOutlet var yourShareValue_label: UILabel!
    @IBOutlet var bgview_view: UIView!
    
    func registerCell() {
        bgview_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        bgview_view.layer.shadowOpacity = 1
        bgview_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        bgview_view.layer.shadowRadius = 1
    }

}

extension RecentCliamsListCell {
    
    func configureRecentClaimCell (item: HPCoverageClaimItem, index: Int) {
        
        let attributes = item.type.attributes()
        doctorValue_label.text = attributes.name
        dateValue_label.text = attributes.date
        billAmtValue_label.text = attributes.billAmt
        yourShareValue_label.text = attributes.share
    }
}
