//
//  ServerRequest.swift
//  HealthProfiler
//

import Foundation
import Alamofire

enum ServerAPI: String {
    
    case login = "app/login"

    case vitals = "Vitals"
    case recentVisit = "RecentVisits"


    public var type: HTTPMethod {
        
        switch self {
        case .login:
            return HTTPMethod.post
            
        default:
            return HTTPMethod.get
        }
    }
}


class ServerRequest {
        
    /// base URL for requests
    public var baseURL: URL? {
        get {
            return URL(string: "https://hprofiler-api-optum-ehr-intlab.ocp-elr-core-nonprod.optum.com/api/")
        }
    }
    
    public static var timeoutInterval: TimeInterval = 30
    
    private func getRequest(with parameters: Parameters, api: ServerAPI) -> URLRequest? {
        
        do {
            if var requestURL = baseURL {
                
                requestURL.appendPathComponent(api.rawValue)
                var request = URLRequest(url: requestURL,
                                         cachePolicy: .reloadIgnoringCacheData,
                                         timeoutInterval: ServerRequest.timeoutInterval)
                
                let methodType = api.type
                request.httpMethod = methodType.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                if methodType == .get {

                    return try Alamofire.URLEncoding.default.encode(request, with: parameters)
                } else {

                    let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                    request.httpBody = jsonData
                    return request
                }
            }
        } catch let error {
            
            debugPrint("========================= SERVER REQUEST ERROR!! =========================")
            debugPrint("\nAPI:\(api.rawValue)\nParams:\(parameters)")
            debugPrint(error)
            debugPrint("=========================================")
        }
        
        return nil
    }
       
}

extension ServerRequest {
    
    //vital list request
    func getVitalDataReq(id: String) -> URLRequest? {
        
        let params: [String : Any] = ["id" : id]
        return getRequest(with: params, api: .vitals)
    }
    
    //Recent visit list request
    func getRecentVisitListReq(id: String) -> URLRequest? {
        
        let params: [String : Any] = ["id" : id]
        return getRequest(with: params, api: .recentVisit)
    }
    
    
    
    
    
    //Auth request
    func getAuthRequest(uid: Int, password: String) -> URLRequest? {
        
        let params: [String : Any] = ["uid" : uid,
                                      "password" : password]
        
        return getRequest(with: params, api: .login)
    }
    
}
