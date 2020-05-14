//
//  AuthConfiguration.swift
//  HealthProfiler
//

import Foundation

struct AuthConfiguration {
    
    let consumerKey: String
    let consumerSecret: String
    let authorizeURL: String
    let accessTokenURL: String
    let callBackURL: String
    let responseType: String
    let contentType: String
    let codeVerifier: String
    let codeChallenge: String
    let codeChallengeMethod: String
    let scope: String
    let state: String

    init(data: Dictionary<String, String>) {

        self.consumerKey = data.valueFor(key: "consumerKey") ?? ""
        self.consumerSecret = data.valueFor(key: "consumerSecret") ?? ""
        self.authorizeURL = data.valueFor(key: "authorizeURL") ?? ""
        self.accessTokenURL = data.valueFor(key: "accessTokenURL") ?? ""
        self.callBackURL = data.valueFor(key: "callBackURL") ?? ""
        self.responseType = data.valueFor(key: "responseType") ?? ""
        self.contentType = data.valueFor(key: "contentType") ?? ""
        self.codeVerifier = data.valueFor(key: "codeVerifier") ?? ""
        self.codeChallenge = data.valueFor(key: "codeChallenge") ?? ""
        self.codeChallengeMethod = data.valueFor(key: "codeChallengeMethod") ?? ""
        self.scope = data.valueFor(key: "scope") ?? ""
        self.state = data.valueFor(key: "state") ?? ""
    }
}
