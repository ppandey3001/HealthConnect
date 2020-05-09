//
//  AppError.swift
//  HealthProfiler
//

import Foundation

public enum AppError: Error {

    case invalidRequest
    case serverError(error: Error)
    case invalidResponse(error: String? = nil)
}

extension AppError {
    
    public var errorMessage: String {
        var message = "Something went wrong."
        
        switch self {
        case .invalidRequest:
            message = "Invalid request."
            
        case .serverError(let error):
            message = error.localizedDescription
            
        case .invalidResponse(let errorMessage):
            message = errorMessage ?? "Invalid response from server."
        }
        
        return message
    }
}
