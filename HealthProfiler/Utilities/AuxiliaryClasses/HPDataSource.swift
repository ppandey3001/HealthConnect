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
    
    var date : String = ""
    var code : String = ""
    var gap : String = ""
    
    
    public  func getGapsInCareDataFrom(dataDict : Dictionary<String, Any>) -> HPGapsInCareItem {
        let obj = HPGapsInCareItem()
        obj.date = "\(dataDict.validatedValue("date", expected: "" as AnyObject))"
        obj.code = "\(dataDict.validatedValue("code", expected: "" as AnyObject))"
        obj.gap = "\(dataDict.validatedValue("gap", expected: "" as AnyObject))"
        
        return obj
    }
    
}

class HPAllergiesItem: NSObject {
    
    var criticality : String = ""
    var status : String = ""
    var allergy : String = ""
    
    
    public  func getAllergyDataFrom(dataDict : Dictionary<String, Any>) -> HPAllergiesItem {
        let obj = HPAllergiesItem()
        obj.criticality = "\(dataDict.validatedValue("criticality", expected: "" as AnyObject))"
        obj.status = "\(dataDict.validatedValue("status", expected: "" as AnyObject))"
        obj.allergy = "\(dataDict.validatedValue("allergy", expected: "" as AnyObject))"
        
        return obj
    }
    
}


class HPConditionItem: NSObject {
    
    var condition : String = ""
    var clinicalStatus : String = ""
    var verificationStatus : String = ""
    
    
    public  func getConditionDataFrom(dataDict : Dictionary<String, Any>) -> HPConditionItem {
        let obj = HPConditionItem()
        obj.condition = "\(dataDict.validatedValue("condition", expected: "" as AnyObject))"
        obj.clinicalStatus = "\(dataDict.validatedValue("clinicalStatus", expected: "" as AnyObject))"
        obj.verificationStatus = "\(dataDict.validatedValue("verificationStatus", expected: "" as AnyObject))"
        
        return obj
    }
    
}

class HPMedicationItem: NSObject {
    
    var dosage : String = ""
    var medicine : String = ""
    
    public  func getMedicationDataFrom(dataDict : Dictionary<String, Any>) -> HPMedicationItem {
        let obj = HPMedicationItem()
        obj.dosage = "\(dataDict.validatedValue("dosage", expected: "" as AnyObject))"
        obj.medicine = "\(dataDict.validatedValue("medicine", expected: "" as AnyObject))"
        
        return obj
    }
    
}

class HPCareTeamItem: NSObject {
    
    var practitioner : String = ""
    var speciality : String = ""
    
    public  func getCareTeamDataFrom(dataDict : Dictionary<String, Any>) -> HPCareTeamItem {
        let obj = HPCareTeamItem()
        obj.practitioner = "\(dataDict.validatedValue("practitioner", expected: "" as AnyObject))"
        obj.speciality = "\(dataDict.validatedValue("speciality", expected: "" as AnyObject))"
        
        return obj
    }
    
}

class HPVitalsItem: NSObject {
    
    var heartrate : String = ""
    var bloodpressure : String = ""
    var bodytemprature : String = ""
    var weight : String = ""
    var bmi : String = ""
    var height : String = ""
    
    public  func getVitalsDataFrom(dataDict : Dictionary<String, Any>) -> HPVitalsItem {
        let obj = HPVitalsItem()
        obj.heartrate = "\(dataDict.validatedValue("heart rate", expected: "" as AnyObject))"
        obj.bloodpressure = "\(dataDict.validatedValue("body pressure", expected: "" as AnyObject))"
        obj.bodytemprature = "\(dataDict.validatedValue("body temprature", expected: "" as AnyObject))"
        obj.weight = "\(dataDict.validatedValue("weight", expected: "" as AnyObject))"
        obj.bmi = "\(dataDict.validatedValue("bmi", expected: "" as AnyObject))"
        obj.height = "\(dataDict.validatedValue("height", expected: "" as AnyObject))"
        
        return obj
    }
    
}

class HPRecentVisitItem: NSObject {
    
    var practitioner : String = ""
    var date : String = ""
    
    public  func getRecentVisitDataFrom(dataDict : Dictionary<String, Any>) -> HPRecentVisitItem {
        let obj = HPRecentVisitItem()
        obj.practitioner = "\(dataDict.validatedValue("practitioner", expected: "" as AnyObject))"
        obj.date = "\(dataDict.validatedValue("date", expected: "" as AnyObject))"
        
        return obj
    }
    
}
