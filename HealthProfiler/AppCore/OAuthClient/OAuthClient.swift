//
//  OAuthClient.swift
//  HealthProfiler
//

import Foundation
import OAuthSwift

class OAuthClient {
    
    //public var
    var provider: AuthProvider!
    
    //private vars
    private var oauth2Client: OAuth2Swift?
    private var config: AuthConfiguration?
    
    init(provider: AuthProvider) {
        
        self.provider = provider
        
        if let providerConfig = self.provider.getConfig() {
            self.config = providerConfig
            
            self.oauth2Client = OAuth2Swift (
                
                consumerKey:    providerConfig.consumerKey,
                consumerSecret: providerConfig.consumerSecret,
                authorizeUrl:   providerConfig.authorizeURL,
                accessTokenUrl: providerConfig.accessTokenURL,
                responseType:   providerConfig.responseType,
                contentType:    providerConfig.contentType
            )
        }
    }
}

enum AuthProvider {
    
    case none
    case blueButton
    
    func getConfig() -> AuthConfiguration? {
        
        var recourceType: ResourceType?
        
        switch self {
        case .blueButton: recourceType = .blueButtonConfig
        default: break
        }
        
        if let rType = recourceType,
            let resourceRawData = AppResource.getData(type: rType) {
            
            do {
                if let data = try JSONSerialization.jsonObject(with: resourceRawData, options: []) as? [String: String],
                    JSONSerialization.isValidJSONObject(data) {
                    
                    return AuthConfiguration(data: data)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}
