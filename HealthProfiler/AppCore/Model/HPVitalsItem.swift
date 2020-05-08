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
        
        heartrate = data.valueFor(key: "heart rate")
        bloodpressure = data.valueFor(key: "body pressure")
        bodytemprature = data.valueFor(key: "body temprature")
        weight = data.valueFor(key: "weight")
        bmi = data.valueFor(key: "bmi")
        height = data.valueFor(key: "height")
    }
}
