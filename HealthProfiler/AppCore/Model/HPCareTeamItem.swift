//
//  HPCareTeamItem.swift
//  HealthProfiler
//

import Foundation

class HPCareTeamItem: NSObject {
    
    var practitioner: String?
    var speciality: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        practitioner = data.valueFor(key: "practitioner")
        speciality = data.valueFor(key: "speciality")
    }
}
