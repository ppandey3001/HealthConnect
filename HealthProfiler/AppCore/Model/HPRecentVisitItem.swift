//
//  HPRecentVisitItem.swift
//  HealthProfiler
//

import Foundation

class HPRecentVisitItem: NSObject {
    
    var practitioner: String?
    var date: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        practitioner = data.valueFor(key: "practitioner")
        date = data.valueFor(key: "date")
    }
}
