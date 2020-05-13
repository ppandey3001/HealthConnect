//
//  PayerSummaryViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit
import OAuthSwift

class PayerSummaryViewController: HPViewController {
    
    @IBOutlet private var view_summary : UIView!
    @IBOutlet private var view_brief : UIView!
    @IBOutlet private var label_healthplan : UILabel!
    @IBOutlet private var tableView_Summary : UITableView!
    
    private let user = HealthProfiler.shared.loggedInUser
    private let services = Services()
    private let oauthswift = OAuth2Swift(
        
        consumerKey:    "gjK4RnBIvCWaj1ocdYyiyKuD8qsmTnRtG2H3RGik",
        consumerSecret: "ld9EvgboAj5Bxe1SHFXbllgsbc4ni3aYH9ct486spRZFERM4U",
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
        
        let codeVerifier = "abcd1234".data(using: .utf8)?.base64EncodedString()
        let codeChallenge : String = "S256"
        
        oauthswift.accessTokenBasicAuthentification = true
        //        oauthswift.allowMissingStateCheck = true
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        let _ = oauthswift.authorize(
        withCallbackURL: "com.optum.com.healthprofiler://callback", scope: "patient/Coverage.read", state: "State01", codeChallenge: codeChallenge, codeChallengeMethod: "S256", codeVerifier: codeVerifier ?? "") { result in
            
            switch result {
                
            case .success(let (credential, _, _)):
                self.showTokenAlert(name: serviceParameters["name"], credential: credential)
                
            case .failure(let error):
                print(error.description)
                UserDefaults.standard.setValue(true, forKey: "isBlueButtonLogin")
                TabBarCoordinator.shared.tabBarStatus(isUserConnected:true)
                self.push(controller: ConnectedPlansViewController.nibInstance())
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


extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
