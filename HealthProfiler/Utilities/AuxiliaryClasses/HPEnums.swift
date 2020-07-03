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
            return ("Dr. Minny Jones", "Jan 6, 2020", "90 USD", "60 USD")
            
        case .drJones:
            return ("Dr. MK Rastogi", "Jan 30, 2020", "650 USD", "350 USD")
            
        case .drAllison:
            return ("Dr. MK Rastogi", "Jan 6, 2020", "70 USD", "30 USD")
            
        case .drNorma:
            return ("Dr. Gayle Laakman", "Jan 30, 2020", "100 USD", "20 USD")
            
        case .drJohn:
            return ("Dr. Gayle Laakman", "Jan 6, 2020", "40 USD", "10 USD")
            
        case .drTammy:
            return ("Dr. MK Rastogi", "Feb 4, 2020", "50 USD", "40 USD")
            
        case .drWilliam:
            return ("Dr. Tammy Allscripts", "Mar 4, 2020", "50 USD", "40 USD")
            
        case .drGayle:
            return ("Dr. Johnson Kary", "Feb 4, 2020", "40 USD", "30 USD")
            
        case .drVeena:
            return ("Dr. John Shier", "Feb 4, 2020", "60 USD", "40 USD")
            
        case .drJohnson:
            return ("Dr. Veena Karthik", "Jan 30, 2020", "200 USD", "150 USD")
            
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

enum HPHistoryConditionType {
    
    case childVisit
    case acute
    case atherosclerosis
    case angina
    case diabeties
    case pneumonia
    case chronic
    case urinary
    case hypertension

    func attributes() -> (condition: String, hospitalLogo: String, visitedOn: String, logo: String) {
        
        switch self {
        case .childVisit:
            return ("Well child visit", "southwestmedical", "Jun 27, 2020", "Allscripts")
            case .acute:
                return ("Acute Pharyngitis", "southwestmedical", "Jun 16, 2020", "Allscripts")
            case .atherosclerosis:
                return ("Atherosclerosis of native arteries of extremities with rest pain, left leg", "adventist", "May 13, 2020", "cerner")
            case .angina:
                return ("Angina Pectoris", "southwestmedical", "Apr 29, 2020", "Allscripts")
            case .diabeties:
                return ("Type 2 Diabetes Mellitus", "southwestmedical", "Apr 01, 2020", "Allscripts")
            case .pneumonia:
                return ("Pneumonia", "southwestmedical", "Mar 26, 2020", "Allscripts")
            case .chronic:
                return ("Chronic kidney disease, stage 3 (moderate)", "adventist", "Mar 13, 2020", "cerner")
            case .urinary:
                return ("Urinary Tract Infection", "southwestmedical", "Jan 10, 2020", "Allscripts")
            
        case .hypertension:
            return ("Hypertension", "southwestmedical", "Dec 12, 2019", "Allscripts")
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
            return ("Humana", "humana-logo")
            
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
    
    func attributes() -> (title: String, icon: String, bgColor: UIColor) {
        
        switch self {
        case .healthInsurance:
            return ("Insurance", "healthInsuranceIcon.png", UIColor.colorFromRGB(24, 188, 155))
            
        case .providers:
            return ("Providers", "provider.png", UIColor.colorFromRGB(47, 204, 113))
            
        case .labs:
            return ("Labs", "LabIcon.png", UIColor.colorFromRGB(52, 152, 219))
            
        case .devices:
            return ("Devices", "DeviceIcon.png", UIColor.colorFromRGB(155, 89, 182))
            
        case .pharmacy:
            return ("Pharmacy", "PharmacyIcon.png", UIColor.colorFromRGB(241, 196, 16))
            
        case .others:
            return ("Others", "Others.png", UIColor.colorFromRGB(231, 76, 60))
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
    
    case profile
    case coverage
    case manageConnections
    case healthProfile
    case claims
    case careTeam
    case vitals
    
    public var title: String {
        
        var itemTitle = ""
        switch self {
            
        case .profile: itemTitle = "Profile"
        case .coverage: itemTitle = "Coverage"
        case .manageConnections: itemTitle = "Manage Connections"
        case .healthProfile: itemTitle = "Health Profile"
        case .claims: itemTitle = "Claims"
        case .careTeam: itemTitle = "Care Team"
        case .vitals: itemTitle = "Vitals"
        }
        
        return itemTitle
    }
}
