//
//  AppResource.swift
//  HealthProfiler
//

import Foundation

class AppResource {
    
    class func getData(type: ResourceType) -> Data? {
        
        var data: Data?
        let resource = type.resource()

        if let filePathURL = Bundle.main.url(forResource: resource.fileName, withExtension: resource.fileExtension) {
            
            do {
                data = try Data(contentsOf: filePathURL)
            } catch  {
                debugPrint("Unable to get the file for: \(type) : \(resource.fileName).\(resource.fileExtension)")
            }
        }

        return data
    }
}


enum ResourceType {
        
    case privacyPolicy
    case demoUserData
    case blueButtonConfig
    
    func resource() -> Resource {
        
        switch self {
        case .privacyPolicy:
            return Resource(name: "privacy_policy", ext: "html")
            
        case .demoUserData:
            return Resource(name: "UserData", ext: "plist")
            
        case .blueButtonConfig:
            return Resource(name: "BlueButtonConfiguration", ext: "json")
        }
    }
}


struct Resource {
    
    let fileName: String
    let fileExtension: String
    
    init(name: String, ext: String) {
        
        self.fileName = name
        self.fileExtension = ext
    }
}
