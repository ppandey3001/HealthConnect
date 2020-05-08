//
//  HPMedicationItem.swift
//  HealthProfiler
//

import Foundation

class HPMedicationItem: NSObject {
    
    var dosage: String?
    var medicine: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        dosage = data.valueFor(key: "dosage")
        medicine = data.valueFor(key: "medicine")
    }
}
