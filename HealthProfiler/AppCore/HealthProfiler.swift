//
//  HealthProfiler.swift
//  HealthProfiler
//

import Foundation

class HealthProfiler {
    
    /// The shared HealthProfiler instance
    public static let shared = HealthProfiler()
    
    /// NetworkManager
    public static var networkManager: NetworkManager {
        get {
            return shared.networkManager
        }
    }
    
    /// Private vars
    private var networkManager: NetworkManager
    
    var loggedInUser: HPUserItem?
    
    //marking init() as 'private' will disallow to create object from outside
    private init() {
        
        self.networkManager = NetworkManager(with: SessionManager())
    }
}


extension HealthProfiler {
    
}
