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
    
    /// OAuthClient for 'Cerner'
    public static var authClientCerner: OAuthClient {
        get {
            return shared.authClientCerner
        }
    }
    /// Private vars
    private var networkManager: NetworkManager
    private var authClient: OAuthClient
    private var authClientCerner: OAuthClient

    var loggedInUser: HPUserItem?
    
    //marking init() as 'private' will disallow to create object from outside
    private init() {
        
        self.networkManager = NetworkManager(with: SessionManager())
        self.authClient = OAuthClient(provider: AuthProvider.blueButton)
        self.authClientCerner = OAuthClient(provider: AuthProvider.cerner)
    }
}


extension HealthProfiler {
    
}
