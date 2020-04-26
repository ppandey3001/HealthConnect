//
//  HPDataSource.swift
//  HealthProfiler
//
//  Created by Krishna Kant Kaira on 26/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import Foundation

class HPMenuItem: NSObject {
    
    var type: HPMenuItemType = .home
    
    init(_ type: HPMenuItemType) {
        
        self.type = type
    }
}
