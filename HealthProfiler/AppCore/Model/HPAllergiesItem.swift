//
//  HPAllergiesItem.swift
//  HealthProfiler
//

import Foundation

class HPAllergiesItem: NSObject {
    
    var criticality: String?
    var status: String?
    var allergy: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        criticality = data.valueFor(key: "criticality")
        status = data.valueFor(key: "status")
        allergy = data.valueFor(key: "allergy")
    }
}
