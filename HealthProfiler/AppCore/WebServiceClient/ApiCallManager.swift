//
//  ApiCallManager.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 07/05/20.
//  Copyright © 2019 Pandey, Pooja. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON


public struct ErrorModel {
    
    var isError : Bool = false
    var errorDescription : String?
    var httpStatusCode : Int?
    var errorCode : Int?
}



public class ApiCallManager {
    
    static let sharedInstance = ApiCallManager()
    var serviceResult = [[String: Any]]()
    let accessToken   = ""
    let refreshToken  = ""
    let baseURL       = "https://hprofiler-api-optum-ehr-intlab.ocp-elr-core-nonprod.optum.com/api/"
    let sessionManager: Session = {
        let manager = ServerTrustManager(evaluators: ["hprofiler-api-optum-ehr-intlab.ocp-elr-core-nonprod.optum.com": DisabledEvaluator()])
        let configuration = URLSessionConfiguration.af.default

        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    
    func fetchDataFromRemote(params : [String: Any], methodType: HTTPMethod, apiName : String , completion:((Any?,ErrorModel)->Void)?){
        ApiCallManager.sharedInstance.fetchDataFromRemote(withBaseURL: baseURL, params: params, methodType: methodType, apiName: apiName, completion: completion)
    }
    
    func fetchDataFromRemote(withBaseURL url:String, params : [String: Any], methodType: HTTPMethod, apiName : String , completion:((Any?,ErrorModel)->Void)?){
        
        guard  let serviceUrl : URL =  URL(string: url + apiName) else {
            return
        }
        
        var encoding:ParameterEncoding = URLEncoding.default
        if methodType == .post {
            encoding = JSONEncoding.default
        }
        
        let headers : HTTPHeaders = ["Content-Type": "application/json" ]

        let queue = DispatchQueue(label: "com.optumhealthconnect-queue", qos: .utility, attributes: [.concurrent])
        sessionManager.request(serviceUrl, method: methodType, parameters: params, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON(queue: queue, options: JSONSerialization.ReadingOptions.allowFragments) { response in
                
                var remoteResult = [[String: Any]]()
                var errorModel = ErrorModel()
                let   httpStatusCode =  response.response?.statusCode
                
                switch response.result {
                case let .success(value):
                    print(value)
                    let jsonVar = JSON(value)
                           
                           //Need to be either array object or dictionary object
                           if let dicArray = jsonVar.arrayObject {
                               remoteResult = dicArray as! [[String : Any]]
                           }
                           else if let dict = jsonVar.dictionaryObject {
                               remoteResult.append(dict)
                           }
                           
                           DispatchQueue.main.async {
                               completion?(remoteResult,errorModel)
                           }
                case let .failure(error):
                    print(error)
                    let   errorDesc = error.localizedDescription
                    let   errorCode = error.responseCode
                    
                    errorModel.isError = true
                    errorModel.errorDescription = errorDesc
                    errorModel.httpStatusCode = httpStatusCode
                    errorModel.errorCode    = errorCode
                    
                    DispatchQueue.main.async {
                        completion?(remoteResult,errorModel)
                    }
                }
        }
    }
    
    func cancelAllAPI() {

        sessionManager.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ (task) in
                task.cancel()
            })
            uploadData.forEach({ (task) in
                task.cancel()
            })
            downloadData.forEach({ (task) in
                task.cancel()
            })
        }
        
    }
    func cancelAPI(apiName : String) {
        let serviceUrl = baseURL + apiName
        sessionManager.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ (task) in
                if (task.originalRequest?.url?.absoluteString ?? "") == serviceUrl {
                    task.cancel()
                }
            })
        }
    }
}

