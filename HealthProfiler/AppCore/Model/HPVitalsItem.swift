//
//  HPVitalsItem.swift
//  HealthProfiler
//

import Foundation

class HPVitalsItem: NSObject {
    
    var heartrate: String?
    var bloodpressure: String?
    var bodytemprature: String?
    var weight: String?
    var bmi: String?
    var height: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        heartrate = data.valueFor(key: "heartrate")
        bloodpressure = data.valueFor(key: "bloodpressure")
        bodytemprature = data.valueFor(key: "bodytemprature")
        weight = data.valueFor(key: "weight")
        bmi = data.valueFor(key: "bmi")
        height = data.valueFor(key: "height")
    }
}
