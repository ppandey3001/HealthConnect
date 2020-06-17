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
    var gender: String?
    var memberID: String?
    var isFirstTimeUser: Bool = false
    var age: String?
    var blueButtonConnected: Bool = false
    var cernerConnected: Bool = false
    var isHumanaConnected: Bool = false
    var isProviderConnected: Bool = false
    var isInsurerConnected: Bool = false
    
    init(_ data: Dictionary<String, Any>) {
        
        id = data.valueFor(key: "id")
        username = data.valueFor(key: "username")
        password = data.valueFor(key: "password")
        email = data.valueFor(key: "email")
        name = data.valueFor(key: "name")
        age = data.valueFor(key: "age")
        gender = data.valueFor(key: "gender")
        memberID = data.valueFor(key: "memberID")
        isFirstTimeUser = data.valueFor(key: "isFirstTimeUser") ?? false
        blueButtonConnected = data.valueFor(key: "blueButtonConnected") ?? false
        cernerConnected = data.valueFor(key: "cernerConnected") ?? false
        isHumanaConnected = data.valueFor(key: "isHumanaConnected") ?? false
        isProviderConnected = data.valueFor(key: "isProviderConnected") ?? false
        isInsurerConnected = data.valueFor(key: "isInsurerConnected") ?? false
    }
}
