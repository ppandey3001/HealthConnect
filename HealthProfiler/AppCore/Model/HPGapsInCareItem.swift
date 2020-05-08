//
//  HPGapsInCareItem.swift
//  HealthProfiler
//

import Foundation

class HPGapsInCareItem: NSObject {
    
    var date: String?
    var code: String?
    var gap: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        date = data.valueFor(key: "date")
        code = data.valueFor(key: "code")
        gap = data.valueFor(key: "gap")
    }
}
