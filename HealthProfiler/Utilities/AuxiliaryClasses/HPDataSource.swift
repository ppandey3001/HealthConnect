//
//  HPDataSource.swift
//  HealthProfiler
//

import Foundation

class HPProfileItem: NSObject {
    
    var type: HPProfileFieldType = .userName
    var value: String?
    
    init(_ type: HPProfileFieldType) {
        
        self.type = type
    }
}


class HPMenuItem: NSObject {
    
    var type: HPMenuItemType = .home
    
    init(_ type: HPMenuItemType) {
        
        self.type = type
    }
}
