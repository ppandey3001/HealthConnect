//
//  HPDataModel.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 07/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import Foundation

class AllergyModal:NSObject {
    var criticality : String = ""
    var status : String = ""
    var allergy : String = ""

    
    public  func getAllergyDataFrom(dataDict : Dictionary<String, Any>) -> AllergyModal {
        let obj = AllergyModal()
        obj.criticality = "\(dataDict.validatedValue("criticality", expected: "" as AnyObject))"
        obj.status = "\(dataDict.validatedValue("status", expected: "" as AnyObject))"
        obj.allergy = "\(dataDict.validatedValue("allergy", expected: "" as AnyObject))"
        
        return obj
    }
    
}
