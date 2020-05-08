//
//  HPConditionItem.swift
//  HealthProfiler
//

import Foundation

class HPConditionItem: NSObject {
    
    var condition: String?
    var clinicalStatus: String?
    var verificationStatus: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        condition = data.valueFor(key: "condition")
        clinicalStatus = data.valueFor(key: "clinicalStatus")
        verificationStatus = data.valueFor(key: "verificationStatus")
    }
}
