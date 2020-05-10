//
//  NetworkManager.swift
//  HealthProfiler
//

import Foundation

class NetworkManager {
    
    private var sessionManager: SessionManager
    private let serverReq: ServerRequest

    init(with sessionManager: SessionManager) {
        
        self.sessionManager = sessionManager
        self.serverReq = ServerRequest()
    }
}

extension NetworkManager {
    
    func getVitalData(id: String,
                      completion: @escaping((HPVitalsItem?, AppError?) -> Void) ) {
        
        if let request = serverReq.getVitalDataReq(id: id) {
            
            sessionManager.request(request) { (data, error) in
                
                if let rawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>>,
                    let vitalItem = rawData.first {
                    
                    completion(HPVitalsItem(vitalItem), nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
    
    
    func getRecentVisitList(id: String,
                      completion: @escaping(([HPRecentVisitItem]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getRecentVisitListReq(id: id) {
            
            sessionManager.request(request) { (data, error) in
                
                if let visitsRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                
                    var visits = [HPRecentVisitItem]()
                    for visitRaw in visitsRawData {
                        visits.append(HPRecentVisitItem(visitRaw))
                    }
                    completion(visits, nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
}
