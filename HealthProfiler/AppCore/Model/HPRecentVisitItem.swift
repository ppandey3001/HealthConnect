//
//  HPRecentVisitItem.swift
//  HealthProfiler
//

import Foundation

class HPRecentVisitItem: NSObject {
    
    var practitioner: String?
    var date: String?
    var day: String?
    var month: String?

    init(_ data: Dictionary<String, Any>) {
        
        practitioner = data.valueFor(key: "practitioner")
        date = data.valueFor(key: "date")
        
        // Set the date formatter and optionally set the formatted date from string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm:ss a"
        if let dateF = dateFormatter.date(from: data.valueFor(key: "date") ?? "") {
             self.day =  HPDateFormatter.shared.getString(from: dateF, format: .day)
             self.month =  HPDateFormatter.shared.getString(from: dateF, format: .month)
         }
    }
}
