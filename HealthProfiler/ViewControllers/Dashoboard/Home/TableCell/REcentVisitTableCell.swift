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
    var dataSource_recentVisit = [HPRecentVisitItem]()
    
    func registerCell() {
        
//        registerCollectionCell(collection, cellClass: RecentVisitCollectionCell.self)
//        collection.dataSource = self
//        collection.delegate = self
//        collection.reloadData()
    }
}

extension REcentVisitTableCell {
    func configureRecentVisitCell(item: HPRecentVisitItem) {
        
        practionerName_label.text = item.practitioner
        date_label.text = item.date
    }
}
