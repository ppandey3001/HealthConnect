//
//  DummyData.swift
//  HealthProfiler
//

import Foundation

class DummyData {
    
    static let shared = DummyData()
    
    var userList: [HPUserItem]?
    
    func loadUserData_demo() {
        
        if let userData = AppResource.getData(type: .demoUserData),
            let plistRawData = try? PropertyListSerialization.propertyList(from: userData, options: .mutableContainers, format: nil) as? [String: Any] {
            
            userList = [HPUserItem]()
            if let ListOfUsers = plistRawData["ListOfUsers"] as? Array<Dictionary<String, Any>> {
                
                for userData in ListOfUsers {
                    if let user = userData["user"] as? [String: Any] {
                        userList?.append(HPUserItem(user))
                    }
                }
            }
        } else {
            debugPrint("Unable to load data.")
        }
    }
}

extension DummyData {
    
    func authorise(username: String, pwd: String, completion: @escaping(HPUserItem?, AppError?)-> Void) {
        
        var authUser: HPUserItem?
        var error: AppError?
        
        if let userList = userList {
            
            error = AppError.invalidResponse(error: "Please enter a valid username")
            
            for user in userList {
                if user.username == username {
                    if user.password == pwd {
                        authUser = user
                    } else {
                        error = AppError.invalidResponse(error: "Password you have entered is incorrect")
                    }
                    
                    break
                }
            }
        } else {
            error = AppError.invalidResponse(error: "No user found")
        }
        
        completion(authUser, error)
    }
}
