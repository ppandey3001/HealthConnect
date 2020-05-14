//
//  PayerSummaryViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit
import OAuthSwift
import SwiftyJSON

class PayerSummaryViewController: HPViewController {
    
    @IBOutlet private var view_summary : UIView!
    @IBOutlet private var view_brief : UIView!
    @IBOutlet private var label_healthplan : UILabel!
    @IBOutlet private var tableView_Summary : UITableView!
    
    private var dataSource_eobList = [HPEobItem]()
    
    private let user = HealthProfiler.shared.loggedInUser
    private let services = Services()
    private let oauthswift = OAuth2Swift(
        
        consumerKey:    "gjK4RnBIvCWaj1ocdYyiyKuD8qsmTnRtG2H3RGik",
        consumerSecret: "ld9EvgboAj5Bxe1SHFXbllgsbc4ni3aYH9ct486spRZFERM4UM6dLDiYg4G8eNQ62D8XJPizes6RaB4h1XEN1jUgo8cgq9cq18eIoYNWHbnQ2Xzu63eRkJRFvRriRQGb",
        authorizeUrl:   "https://sandbox.bluebutton.cms.gov/v1/o/authorize/",
        accessTokenUrl: "https://sandbox.bluebutton.cms.gov/v1/o/token/",
        
        responseType:   "code",
        contentType:    "application/json"
    )
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func payerDetailAction(_ sender : UIButton) {
        
        view_brief.isHidden = true
    }
    
    @IBAction func showDetailsAction(_ sender : UIButton){
        
        let briefView = tableView_Summary.viewWithTag(sender.tag)
        briefView?.isHidden = true
        tableView_Summary.reloadData()
    }
    
    @IBAction func blueButtonAction(_ sender : UIButton) {
        
        var parameters = [String:String]()
        parameters["consumerKey"] = "gjK4RnBIvCWaj1ocdYyiyKuD8qsmTnRtG2H3RGik"
        parameters["consumerSecret"] = "ld9EvgboAj5Bxe1SHFXbllgsbc4ni3aYH9ct486spRZFERM4U"
        
        callBlueBUttonApi(parameters)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton){
        
        push(controller: ConnectedPlansViewController.nibInstance())
    }
    
}

//MARK: Private methods
private extension PayerSummaryViewController {
    
    private func setupController() {
        
        view_summary.layer.borderColor = UIColor.orange.cgColor
        view_summary.layer.borderWidth = 1.0
        
        UserDefaults.standard.setValue(true, forKey: "isInsurerConnected")
        
        registerTableCell(tableView_Summary, cellClass: SummaryBenefitCell.self)
        
        tableView_Summary.delegate = self
        tableView_Summary.dataSource = self
        tableView_Summary.reloadData()
    }
    
    func showTokenAlert(name: String?, credential: OAuthSwiftCredential) {
        
        var message = "oauth_token:\(credential.oauthToken)"
        if !credential.oauthTokenSecret.isEmpty {
            message += "\n\noauth_token_secret:\(credential.oauthTokenSecret)"
        }
        self.showAlertView(title: name ?? "Service", message: message)
        
        if let service = name {
            services.updateService(service, dico: ["authentified":"1"])
            // TODO refresh graphic
        }
    }
    
    func showAlertView(title: String, message: String) {
        
        #if os(iOS)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        #elseif os(OSX)
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.addButton(withTitle: "Close")
        alert.runModal()
        #endif
    }
    
    private func callBlueBUttonApi(_ serviceParameters: [String:String]) {
        
        HealthProfiler.authClient.authorize(controller: self) { (token, error) in
            
            if let token = token {
                
                UserDefaults.standard.setValue(true, forKey: "isBlueButtonLogin")
                
                TabBarCoordinator.shared.tabBarStatus(isUserConnected:true)
                self.push(controller: ConnectedPlansViewController.nibInstance())
                self.callApiForEobList(token: token)
            } else {
                debugPrint(error.debugDescription)
            }
        }
        
        
//        let codeVerifier = "wDAdQ_RVQuyGG3MgtlwMTOiB_ro.WMes96GFE6fVrp_WBezUZyfPcIAsThvfv0Be8CLirB4v8Cp2E.8Ug4dZ7s7pOGm4J3avLALFxqIDtrWLIi_X-.3X8pBiZgRmJs7a"
//        let codeChallenge : String = "nzH8oPZloiNJ-kUk0vJXI_vw5rU1mSODyFgPT3lkcIk"
//
//        oauthswift.accessTokenBasicAuthentification = true
//        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
//        let _ = oauthswift.authorize(
//        withCallbackURL: "com.optum.com.healthprofiler://callback", scope: "patient/ExplanationOfBenefit.read", state: "State01", codeChallenge: codeChallenge, codeChallengeMethod: "S256", codeVerifier: codeVerifier) { result in
//
//            switch result {
//
//            case .success(let (credential, _, _)):
//                print(credential.oauthToken)
//
//                UserDefaults.standard.setValue(true, forKey: "isBlueButtonLogin")
//
//                TabBarCoordinator.shared.tabBarStatus(isUserConnected:true)
//                self.push(controller: ConnectedPlansViewController.nibInstance())
//                self.callApiForEobList(token: credential.oauthToken)
//
//            case .failure(let error):
//                print(error.description)
//
//            }
//        }
    }
    
}

//MARK: - API interaction -
extension PayerSummaryViewController {
    
    private func callApiForEobList(token : String) {
        
        Loader.show()
        
        HealthProfiler.networkManager.getEobData(token: token) { [weak self] (eobList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                strongSelf.dataSource_eobList.removeAll()
                if let eobList = eobList {
                    strongSelf.dataSource_eobList = eobList
                    //                    strongSelf.recent_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
}


extension PayerSummaryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let summaryCell = tableView.dequeueReusableCell(withIdentifier: SummaryBenefitCell.reuseableId(), for: indexPath) as! SummaryBenefitCell
        
        summaryCell.medicareDetail_button.addTarget(self, action: #selector(showDetailsAction), for: .touchUpInside)
        summaryCell.pharmacyDetail_button.addTarget(self, action: #selector(showDetailsAction), for: .touchUpInside)
        
        return summaryCell
    }
}
