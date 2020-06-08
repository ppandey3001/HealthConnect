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
    
    func authorize(controller: UIViewController, completion: @escaping ((String?, Error?) -> Void)) {
        
        guard let oauth2Client = oauth2Client else {
            return
        }
        guard let config = config else {
            return
        }
        
        oauth2Client.accessTokenBasicAuthentification = true
        oauth2Client.authorizeURLHandler = SafariURLHandler(viewController: controller, oauthSwift: oauth2Client)
        oauth2Client.authorize(withCallbackURL: config.callBackURL,
                               scope: config.scope,
                               state: config.state,
                               codeChallenge: config.codeChallenge,
                               codeChallengeMethod: "S256",
                               codeVerifier: config.codeVerifier) { result in
                                
                                DispatchQueue.main.async {
                                    
                                    switch result {
                                        
                                    case .success(let (credential, _, _)):
                                        completion(credential.oauthToken, nil)
                                        
                                    case .failure(let error):
                                        completion(nil, error)
                                    }
                                }
        }
    }
    
}



enum AuthProvider {
    
    case none
    case blueButton
    case cerner
    
    func getConfig() -> AuthConfiguration? {
        
        var recourceType: ResourceType?
        
        switch self {
        case .cerner: recourceType = .cernerConfig
            
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
