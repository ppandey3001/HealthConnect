//
//  ServiceManager.swift
//  HealthProfiler
//

import Foundation
import Alamofire

class SessionManager {
    
    let session: Session = {
        let manager = ServerTrustManager(evaluators: ["hprofiler-api-optum-ehr-intlab.ocp-elr-core-nonprod.optum.com": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    
    /// Handle a request
    /// Returns a serverresponse object for further deserialising in the calling class
    public func request(_ request: URLRequest, completion: @escaping ([String : Any]?, AppError?) -> Void) {
                
        session.request(request)
            .validate()
            .responseJSON { response in
                
                DispatchQueue.main.async {
                    
                    #if DEBUG
                        debugPrint("================ !! Server Response !! ================")
                        print(response.debugDescription)
                        debugPrint("=========================================")
                    #endif
                    
                    switch response.result {
                        
                    case .success(let value):
                        
                        if JSONSerialization.isValidJSONObject(value),
                            let json = value as? [String : Any] {
                            completion(json, nil)
                        } else {
                            completion(nil, AppError.invalidResponse())
                        }
                        
                    case .failure(let error):
                        completion(nil, AppError.serverError(error: error))
                    }
                }
        }
    }
}
