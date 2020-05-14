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
    
    /// OAuthClient for 'BlueButton'
    public static var authClient: OAuthClient {
        get {
            return shared.authClient
        }
    }
    
    /// Private vars
    private var networkManager: NetworkManager
    private var authClient: OAuthClient

    var loggedInUser: HPUserItem?
    
    //marking init() as 'private' will disallow to create object from outside
    private init() {
        
        self.networkManager = NetworkManager(with: SessionManager())
        self.authClient = OAuthClient(provider: AuthProvider.blueButton)
    }
}


extension HealthProfiler {
    
}
