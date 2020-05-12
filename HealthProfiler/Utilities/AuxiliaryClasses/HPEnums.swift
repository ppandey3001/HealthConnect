//
//  HPEnums.swift
//  HealthProfiler
//

import Foundation
import UIKit


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
    
    func attributes() -> (title: String, placeholder: String) {
        
        switch self {
        case .planID:
            return ("Health Plan ID", "")
            
        case .memberID:
            return ("Member ID", "")
            
        case .dateOfBirth:
            return ("Date Of Birth", "mm/dd/yyyy")
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
                return ("Dr. Minny Jones", "Feb 4, 2020", "90 USD", "60 USD")
        case .drJones:
                return ("Dr. Minny Jones", "Feb 4, 2020", "650 USD", "350 USD")
        case .drAllison:
                return ("Dr. Allison Allscripts", "Mar 4, 2020", "70 USD", "30 USD")
        case .drNorma:
                return ("Dr. Norma Lewi", "Mar 4, 2020", "100 USD", "20 USD")
        case .drJohn:
                return ("Dr. John Shier", "Jan 6, 2020", "40 USD", "10 USD")
        case .drTammy:
                return ("Dr. Tammy Allscripts", "Jan 6, 2020", "50 USD", "40 USD")
        case .drWilliam:
                return ("Dr. William Richards", "Mar 4, 2020", "50 USD", "40 USD")
        case .drGayle:
                return ("Dr. Gayle Laakman", "Jab 30, 2020", "40 USD", "30 USD")
        case .drVeena:
                return ("Dr. Veena Karthik", "Jab 30, 2020", "60 USD", "40 USD")
        case .drJohnson:
                return ("Dr. Johnson Kary", "Jab 30, 2020", "200 USD", "150 USD")
        }
    }
    
}

enum HPGapsInCareType {
    
    case appointment
    case fluShot
    case diabeties
    case amaryl
    case duetact
    
    func attributes() -> (name : String, bgColor: UIColor) {
        
        switch self {
        case .appointment:
            return("Missed appointment", UIColor.colorFromRGB(229.0, 244.0, 214.0))
            
        case .fluShot:
            return("Flu shot missed", UIColor.colorFromRGB(224.0, 224.0, 224.0))
            
        case .diabeties:
            return("Diabetes - Eye Exam", UIColor.colorFromRGB(250.0, 218.0, 198.0))
            
        case .amaryl:
            return("Missed Rx Refill - Amaryl", UIColor.colorFromRGB(250.0, 232.0, 198.0))
            
        case .duetact:
            return("Missed Rx Refill - Duetact", UIColor.colorFromRGB(250.0, 232.0, 198.0))
        }
    }
}

enum HPAllergiesType {
    
    case cephalosporin
    case sulfonamides
    case cetaphil
    case hydrochlorophate
    case parabbin
    
    func attributes() -> (name : String, bgColor: UIColor) {
        
        switch self {
        case .cephalosporin:
            return("Cephalosporin", UIColor.colorFromRGB(236.0, 236.0, 236.0))
            
        case .sulfonamides:
            return("Sulfonamides", UIColor.colorFromRGB(236.0, 236.0, 236.0))
            
        case .cetaphil:
            return("Cetaphil", UIColor.colorFromRGB(236.0, 236.0, 236.0))
            
        case .hydrochlorophate:
            return("Hydrochlorophate", UIColor.colorFromRGB(236.0, 236.0, 236.0))
            
        case .parabbin:
            return("Parabbin", UIColor.colorFromRGB(236.0, 236.0, 236.0))
        }
    }
}

enum HPConditionType {
    
    case diabetes
    case backache
    case survical
    case bloodpressure
    
    func attributes() -> (name : String, bgColor: UIColor) {
        
        switch self {
        case .diabetes:
            return("Diabetes Type-2", .clear)
            
        case .backache:
            return("Back Ache", .clear)
            
        case .survical:
            return("Servical", .clear)
            
        case .bloodpressure:
            return("Blood Pressure", .clear)
        }
    }
}

enum HPMedicationType {
    
    case amoxicillin
    case cephalexin
    
    func attributes() -> (name : String, dose: String, tillDate : String) {
        
        switch self {
        case .amoxicillin:
            return("Amoxicillin 250 MG/5ML", "3 tablets every day", "until 2nd June")
            
        case .cephalexin:
            return("Cephalexin 500 MG Cap", "2 Caps every day", "until 15TH June")
        }
    }
}

enum HPCareTeamType {
    
    case william
    case mindy
    case veena
    case sharon
    case rodney
    
    func attributes() -> (name : String, speciality: String) {
        
        switch self {
            
        case .william:
            return("Dr. Williams Richards", "Cardiology")
            
        case .mindy:
            return("Dr. Mindy Jones", "Gen. Surgery")
            
        case .veena:
            return("Dr. Veena Krithik", "Cardiology")
            
        case .sharon:
            return("Dr. Sharon Colbert", "Endocrinology")
            
        case .rodney:
            return("Dr. Rodney Roe", "Optometrist")
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
            return ("United Health Care", "medicareLogo")
            
        case .humana:
                return ("Humana", "medicareLogo")
            
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
