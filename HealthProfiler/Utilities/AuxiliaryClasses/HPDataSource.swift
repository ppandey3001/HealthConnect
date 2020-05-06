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


class HPConnectionItem: NSObject {
    
    var type: HPConnectionTabType = .healthInsurance
    var isConnected: Bool = false
    
    init(_ type: HPConnectionTabType) {
        
        self.type = type
    }
}


class HPMenuItem: NSObject {
    
    var type: HPMenuItemType = .home
    
    init(_ type: HPMenuItemType) {
        
        self.type = type
    }
}


class HPHealthInsuranceItem: NSObject {
    
    var type: HPHealthInsuranceType = .choosePayer
    var value: String?
    
    init(_ type: HPHealthInsuranceType) {
        
        self.type = type
    }
}


class HPConnectedInsuranceItem: NSObject {
    
    var type: HPConnectedInsuranceType = .medicare
    var value: String?
    
    init(_ type: HPConnectedInsuranceType) {
        
        self.type = type
    }
}

class HPConnectedProviderItem: NSObject {
    
    var type: HPConnectedProviderType = .epicSystem
    var value: String?
    
    init(_ type: HPConnectedProviderType) {
        
        self.type = type
    }
}

class HPCoverageClaimItem: NSObject {
    
    var type: HPCoverageClaimType = .drPOe
    
    init(_ type: HPCoverageClaimType) {
        
        self.type = type
    }
}

class HPGapsInCareItem: NSObject {
    
    var type: HPGapsInCareType = .appointment
    
    init(_ type: HPGapsInCareType) {
        
        self.type = type
    }
}

class HPAllergiesItem: NSObject {
    
    var type: HPAllergiesType = .cephalosporin
    
    init(_ type: HPAllergiesType) {
        
        self.type = type
    }
}

class HPConditionItem: NSObject {
    
    var type: HPConditionType = .diabetes
    
    init(_ type: HPConditionType) {
        
        self.type = type
    }
}

class HPMedicationItem: NSObject {
    
    var type: HPMedicationType = .amoxicillin
    
    init(_ type: HPMedicationType) {
        
        self.type = type
    }
}

class HPCareTeamItem: NSObject {
    
    var type: HPCareTeamType = .william
    
    init(_ type: HPCareTeamType) {
        
        self.type = type
    }
}
