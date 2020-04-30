//
//  HPEnums.swift
//  HealthProfiler
//

import Foundation

enum HPProfileFieldType {
    
    case userName
    case password
    case confirmPassword
    case name
    case email

    func attributes() -> (placeholder: String, isSecure: Bool, icon: String) {
        
        switch self {
        case .userName:
            return ("username", false, "user-icon.png")
            
        case .password:
            return ("password", true, "password-icon.png")
            
        case .confirmPassword:
            return ("confirm password", true, "password-icon.png")
            
        case .name:
            return ("name", false, "name.png")
            
        case .email:
            return ("email", false, "email.png")
        }
    }
}


enum HPConnectionTabType {
    
    case healthInsurance
    case providers
    case labs
    case devices
    case pharmacy
    case others

    func attributes() -> (labelTitle: String, status: Bool, icon: String) {
        
        switch self {
        case .healthInsurance:
            return ("Health Insurance", false, "healthInsuranceIcon.png")
            
        case .providers:
            return ("Providers", false, "DoctorIcon.png")
            
        case .labs:
            return ("Labs", false, "LabIcon.png")
            
        case .devices:
            return ("Devices", false, "DeviceIcon.png")
            
        case .pharmacy:
            return ("Pharmacy", false, "PharmacyIcon.png")
            
        case .others:
            return ("Others", false, "OthersIcon.png")
        }
    }
}


enum HPTabType {
    
    case home
    case healthProfile
    case coverage
    case manageConnections
    
    public var tabIndex: Int {
        
        switch self {
        case .home:  return 0
        case .healthProfile: return 1
        case .coverage: return 2
        case .manageConnections: return 3
        }
    }
}

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
