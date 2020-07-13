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

class HPHumanaItem: NSObject {
    
    var type: HPHumanaType = .planID
    var value: String?
    
    init(_ type: HPHumanaType) {
        
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
    
    var type: HPMenuItemType = .profile
    
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
    
    var type: HPConnectedProviderType = .methodist
    var isConnected: Bool?
    
    init(_ type: HPConnectedProviderType) {
        
        self.type = type
    }
}


class HPCernerCareTeamItem: NSObject {
    
    var type: HPCernerCareTeamType = .john
    
    init(_ type: HPCernerCareTeamType) {
        
        self.type = type
    }
}


class HPCoverageClaimItem: NSObject {
    
    var type: HPCoverageClaimType = .drMinnnie
    
    init(_ type: HPCoverageClaimType) {
        
        self.type = type
    }
}


class HPCernerConditionItem: NSObject {
    
    var type: HPCernerConditionType = .atherosclerosis
    
    init(_ type: HPCernerConditionType) {
        
        self.type = type
    }
}

class HPHistoryConditionItem: NSObject {
    
    var type: HPHistoryConditionType = .childVisit
    
    init(_ type: HPHistoryConditionType) {
        
        self.type = type
    }
}

class HPSegmentItem: NSObject {
    
    var type: HPSegmentType = .conditions
    
    init(_ type:  HPSegmentType) {
        
        self.type = type
    }
}

class HPAllergyItem: NSObject {
    
    var type: HPAllergyType = .morphine
    
    init(_ type:  HPAllergyType) {
        
        self.type = type
    }
}

class HPMedicationsItem: NSObject {
    
    var type: HPMedicationType = .amiodrane
    
    init(_ type:  HPMedicationType) {
        
        self.type = type
    }
}
    
class HPRecentVisitsItem: NSObject {
    
    var type: HPRecentVisitType = .allscript1
    
    init(_ type:  HPRecentVisitType) {
        
        self.type = type
    }
    
}

class HPGapsItem: NSObject {
    
    var type: HPGapsType = .fraility
    
    init(_ type:  HPGapsType) {
        
        self.type = type
    }
}


