//
//  HPEnums.swift
//  HealthProfiler
//

import Foundation


enum HPWebContentType {
    
    case privacyPolicy
    case termsCondition
    case content(html: String)
}

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

enum HPHealthInsuranceType {
    
    case choosePayer
    case planID
    case memberID
    
    func attributes() -> (placeholder: String, isSecure: Bool, icon: String?) {
        
        switch self {
        case .choosePayer:
            return ("Choose your payer", false, nil)
            
        case .planID:
            return ("Health plan ID", true, nil)
            
        case .memberID:
            return ("Member ID", true, "name.png")
            
        }
    }
}

enum HPConnectedProviderType {
    
    case epicSystem
    case cemer
    case allScripts
    
    func attributes() -> (title: String, icon : String) {
        
        switch self {
        case .epicSystem:
            return  ("Powered by Epic Systems", "alberta")
            
        case .cemer:
            return ("Powered by Cemer", "midland")
            
        case .allScripts:
            return ("Powered by Allscripts", "alina_health")
            
        }
    }
}

enum HPCoverageClaimType {
    
    case drPOe
    case drSmith
    
    func attributes() -> (name : String, date : String, billAmt : String, share : String) {
        
        switch self {
        case .drPOe:
            return  ("Dr. Poe", "Mar 8", "$xx", "$xx")
            
        case .drSmith:
            return ("Dr. Smith", "Mar 4", "$xx", "$xx")
            
        }
    }
    
}

enum HPConnectedInsuranceType {
    case medicare
    case blueButton
    
    func attributes() -> (title: String, icon: String) {
        
        switch self {
        case .medicare:
            return ("Medicare Advantage PPO", "medicareLogo")
            
        case .blueButton:
            return ("Blue Button 2.0", "ConnectImage")
            
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
    
    func attributes() -> (title: String, icon: String) {
        
        switch self {
        case .healthInsurance:
            return ("Health Insurance", "healthInsuranceIcon.png")
            
        case .providers:
            return ("Providers", "DoctorIcon.png")
            
        case .labs:
            return ("Labs", "LabIcon.png")
            
        case .devices:
            return ("Devices", "DeviceIcon.png")
            
        case .pharmacy:
            return ("Pharmacy", "PharmacyIcon.png")
            
        case .others:
            return ("Others", "OthersIcon.png")
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
