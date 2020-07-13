//
//  HPEobItem.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 13/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HPEobItem: NSObject {
    
    var billedAmmount: String?
    var dateOfVisit: String?
    var name: String?
    var sharePart: String?
    var status: String?
    var date: Date = Date()
    
    init(_ data: Dictionary<String, Any>) {
        
        billedAmmount = data.valueFor(key: "Billed Amount")
        dateOfVisit = data.valueFor(key: "Date of Visit")
        name = data.valueFor(key: "Visited (dr. name)")
        sharePart = data.valueFor(key: "Your responsibility ")
        status = data.valueFor(key: "status")
        // Set the date formatter and optionally set the formatted date from string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let date = dateFormatter.date(from: data.valueFor(key: "Date of Visit") ?? "") {
            self.date = date
        }
    }
    
}
