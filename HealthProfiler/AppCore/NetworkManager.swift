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
    
    func getEobData(token: String,
                    completion: @escaping(([HPEobItem]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getEobDataReq(token: token) {
            
            sessionManager.request(request) { (data, error) in
                
                if let eobRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                    
                    var eobs = [HPEobItem]()
                    for eobRaw in eobRawData {
                        eobs.append(HPEobItem(eobRaw))
                    }
                    completion(eobs, nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
    
    
    func getAllergyData(id: String,
                        completion: @escaping(([HPAllergiesItem]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getAllergyDataReq(id: id) {
            
            sessionManager.request(request) { (data, error) in
                
                if let allergyRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                    
                    var allergies = [HPAllergiesItem]()
                    for allergyRaw in allergyRawData {
                        allergies.append(HPAllergiesItem(allergyRaw))
                    }
                    completion(allergies, nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
    
    func getGapsInCareData(
        completion: @escaping(([HPGapsInCareItem]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getGapsInCareDataReq() {
            
            sessionManager.request(request) { (data, error) in
                
                if let allergyRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                    
                    var allergies = [HPGapsInCareItem]()
                    for allergyRaw in allergyRawData {
                        allergies.append(HPGapsInCareItem(allergyRaw))
                    }
                    completion(allergies, nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
    
    func getCarePlanData(
        completion: @escaping((HPCarePlanItem?, AppError?) -> Void) ) {
        
        if let request = serverReq.getCarePlanDataReq() {
            
            sessionManager.request(request) { (data, error) in
                
                if let rawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>>,
                    let carePlanItem = rawData.first {
                    
                    completion(HPCarePlanItem(carePlanItem), nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
    
    
    
    func getMedicationData(id: String,
                           completion: @escaping(([HPMedicationItem]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getMedicationListReq(id: id) {
            
            sessionManager.request(request) { (data, error) in
                
                if let medicationRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                    
                    var medications = [HPMedicationItem]()
                    for medicationRaw in medicationRawData {
                        medications.append(HPMedicationItem(medicationRaw))
                    }
                    completion(medications, nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
    
    
    func getConditionData(id: String,
                          completion: @escaping(([HPConditionItem]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getConditionListReq(id: id) {
            
            sessionManager.request(request) { (data, error) in
                
                if let conditionRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                    
                    var conditions = [HPConditionItem]()
                    for conditionRaw in conditionRawData {
                        conditions.append(HPConditionItem(conditionRaw))
                    }
                    completion(conditions, nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
    
    
    func getCareTeamData(id: String,
                         completion: @escaping(([HPCareTeamItem]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getCareTeamListReq(id: id) {
            
            sessionManager.request(request) { (data, error) in
                
                if let careTeamRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                    
                    var careTeams = [HPCareTeamItem]()
                    for careTeamRaw in careTeamRawData {
                        careTeams.append(HPCareTeamItem(careTeamRaw))
                    }
                    completion(careTeams, nil)
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
    
    func getCostEstimatorResultList(id: String,
                            completion: @escaping(([HPCostEstimatorList]?, AppError?) -> Void) ) {
        
        if let request = serverReq.getCostEstimatorListReq(id: id) {
            
            sessionManager.request(request) { (data, error) in
                
                if let estimatorRawData = data?[SessionManager.dataKey] as? Array<Dictionary<String, Any>> {
                    
                    var lists = [HPCostEstimatorList]()
                    for listRaw in estimatorRawData {
                        lists.append(HPCostEstimatorList(listRaw))
                    }
                    completion(lists, nil)
                } else {
                    completion(nil, error ?? AppError.invalidResponse())
                }
            }
        } else {
            completion(nil, AppError.invalidRequest)
        }
    }
}
