//
//  HealthProfiler.swift
//  HealthProfiler
//

import Foundation

class HealthProfiler {
    
    /// The shared HealthProfiler instance
    public static var shared: HealthProfiler {
        get {
            return sharedProfiler
        }
    }
    // MARK: - Private functions
    private static var sharedProfiler: HealthProfiler = {
        
        let instance = HealthProfiler()
        return instance
    }()
    
    
}
