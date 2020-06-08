//
//  HPCostEstimatorList.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 08/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HPCostEstimatorList: NSObject {
    
    var address: String?
    var practionter: String?
    var radius: String?
    var speciality: String?

    init(_ data: Dictionary<String, Any>) {
        
        address = data.valueFor(key: "address")
        practionter = data.valueFor(key: "practionter")
        radius = data.valueFor(key: "radius")
        speciality = data.valueFor(key: "speciality")
    }
}
