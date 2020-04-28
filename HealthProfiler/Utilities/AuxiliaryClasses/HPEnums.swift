//
//  HPEnums.swift
//  HealthProfiler
//
//  Created by Krishna Kant Kaira on 26/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import Foundation

enum HPMenuItemType {
    
    case home
    case myProfile
    case manageConnections
    case myHealthProfile
    case coverage
    case myCareTeam
    case settings

    public var title: String {
        
        var itemTitle = ""
        switch self {
            
        case .home: itemTitle = "Home"
        case .myProfile: itemTitle = "My Profile"
        case .manageConnections: itemTitle = "Manage Connections"
        case .myHealthProfile: itemTitle = "My Health Profile"
        case .coverage: itemTitle = "Coverage"
        case .myCareTeam: itemTitle = "My Care Team"
        case .settings: itemTitle = "Settings"
        }
        
        return itemTitle
    }
}


enum HPTabType {
    
    case home
    case healthProfile
    case coverage
    case manageConnections
    
    public var tabIndex: Int {
        
        switch self {
        case .home:
            return 0
            
        case .healthProfile:
            return 1
            
        case .coverage:
            return 2
            
        case .manageConnections:
            return 3
        }
    }
}
