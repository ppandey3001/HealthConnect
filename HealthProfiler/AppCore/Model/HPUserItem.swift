//
//  HPUserItem.swift
//  HealthProfiler
//

import Foundation

class HPUserItem: NSObject {
    
    var id: String?
    var username: String?
    var password: String?
    var email: String?
    var name: String?
    var isFirstTimeUser: Bool = false
    var age: String?

    init(_ data: Dictionary<String, Any>) {
        
        id = data.valueFor(key: "id")
        username = data.valueFor(key: "username")
        password = data.valueFor(key: "password")
        email = data.valueFor(key: "email")
        name = data.valueFor(key: "name")
        isFirstTimeUser = data.valueFor(key: "isFirstTimeUser") ?? false
        age = data.valueFor(key: "age")
    }
}
