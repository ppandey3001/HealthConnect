//
//  REcentVisitTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 07/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class REcentVisitTableCell: HPTableViewCell {
    
    @IBOutlet var practionerName_label : UILabel!
    @IBOutlet var date_label : UILabel!
    @IBOutlet var day_label : UILabel!
    @IBOutlet var month_label : UILabel!
    var dataSource_recentVisit = [HPRecentVisitItem]()
    
    let arra = ["Cardiology", "Urology", "General Physician", "Oncology", "Neurology", "Cardiology"]
    
}

extension REcentVisitTableCell {
    func configureRecentVisitCell(item: HPRecentVisitItem, index : Int) {
        
        practionerName_label.text = item.practitioner
        //        if index <= arra.count {
        //
        //            date_label.text = arra[index]
        //
        //        }
        date_label.text = item.date
        day_label.text = item.day
        month_label.text = item.month
    }
    
    func configureRecentVisitStaticCell(item: HPRecentVisitsItem, index : Int) {
        
        let attributes = item.type.attributes()

        practionerName_label.text = attributes.name
        //        if index <= arra.count {
        //
        //            date_label.text = arra[index]
        //
        //        }
        date_label.text = attributes.date
        day_label.text = attributes.day
        month_label.text = attributes.month
    }
}
