//
//  HPEnums.swift
//  HealthProfiler
//
import Foundation
import UIKit
import DataCache


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
            return ("Username", false, "user-icon.png")
            
        case .password:
            return ("Password", true, "password-icon.png")
            
        case .confirmPassword:
            return ("Confirm password", true, "password-icon.png")
            
        case .name:
            return ("Name", false, "name.png")
            
        case .email:
            return ("Email", false, "email.png")
        }
    }
}

enum HPHumanaType {
    
    case planID
    case memberID
    case dateOfBirth
    case username
    case password
    
    func attributes() -> (title: String, placeholder: String) {
        
        switch self {
        case .planID:
            return ("Health Plan ID", "")
            
        case .memberID:
            return ("Member ID", "")
            
        case .dateOfBirth:
            return ("Date Of Birth", "mm/dd/yyyy")
            
        case .username:
            return ("Username", "username")
            
        case .password:
            return ("Password", "password")
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
        
        case methodist
        case advent
        case southwest
        
        func attributes() -> (title: String, icon : String, poweredBy : String) {
            
            switch self {
            case .methodist:
                return  ("Dr. John Shier - Family Practice", "methodist", "cerner")
                
            case .advent:
                return ("Dr. Minny Jones - Neurology", "adventist", "cerner")
                
            case .southwest:
                return ("Dr. William Richards - Cardilogy", "southwestmedical", "Allscripts")
            }
        }
    }
    
    enum HPCoverageClaimType {
        
        case drPOe
        case drSmith
        
        case drMinnnie
        case drJones
        case drAllison
        case drNorma
        case drJohn
        case drTammy
        case drWilliam
        case drGayle
        case drVeena
        case drJohnson
        
        func attributes() -> (name : String, date : String, billAmt : String, share : String) {
            
            switch self {
            case .drPOe:
                return  ("Dr. Poe", "Mar 8", "$xx", "$xx")
                
            case .drSmith:
                return ("Dr. Smith", "Mar 4", "$xx", "$xx")
            case .drMinnnie:
                return ("Dr. Norma Lewis", "Jab 30, 2020", "90 USD", "60 USD")
            case .drJones:
                return ("Dr. Norma Lewis", "Jab 30, 2020", "650 USD", "350 USD")
            case .drAllison:
                return ("Dr. Norma Lewis", "Jan 6, 2020", "70 USD", "30 USD")
            case .drNorma:
                return ("Dr. Norma Lewis", "Jab 30, 2020", "100 USD", "20 USD")
            case .drJohn:
                return ("Dr. Tammy Allscripts", "Mar 4, 2020", "40 USD", "10 USD")
            case .drTammy:
                return ("Dr. MK Rastogi", "Mar 4, 2020", "50 USD", "40 USD")
            case .drWilliam:
                return ("Dr. Gayle Laakman", "Mar 4, 2020", "50 USD", "40 USD")
            case .drGayle:
                return ("Dr. MK Rastogi", "Jan 6, 2020", "40 USD", "30 USD")
            case .drVeena:
                return ("Dr. Minny Jones", "Jab 30, 2020", "60 USD", "40 USD")
            case .drJohnson:
                return ("Dr. Norma Lewis", "Feb 4, 2020", "200 USD", "150 USD")
            }
        }
        
    }

    enum HPCernerConditionType {
        
        case atherosclerosis
        case chronic
        
        func attributes() -> (condition: String, Evaluation: String, Goal: String, lastVisit: String, status: String, otherActions : String) {
            
            switch self {
            case .atherosclerosis:
                return ("Atherosclerosis of native arteries of extremities with rest pain, left leg", "", "", "", "", "")
                
            case .chronic:
                return ("Chronic kidney disease, stage 3 (moderate)", "", "", "", "", "")

            }
        }
    }
    
    enum HPConnectedInsuranceType {
        
        case medicare
        case blueButton
        case humana
        
        func attributes() -> (title: String, icon: String) {
            
            switch self {
            case .medicare:
                return ("United Health Care", "uhc")
                
            case .humana:
                return ("Humana", "humana")
                
            case .blueButton:
                return ("Blue Button 2.0", "bluebutton")
            }
        }
    }
    
    enum HPCernerCareTeamType {
        
        case john
        case jonson
        
        func attributes() -> (name: String, speciality: String) {
            
            switch self {
            case .john:
                return ("Dr. John Shier", "Family Practice")
                
            case .jonson:
                return ("Dr. Johnson Kary", "Cardiology")
                
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
        case myProfile

        public var tabIndex: Int {
            
            switch self {
            case .home:  return 0
            case .healthProfile: return 1
            case .coverage: return 2
            case .manageConnections: return 3
            case .myProfile: return 4
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
