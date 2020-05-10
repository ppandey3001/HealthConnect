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
        callBlueBUttonApi()
//        push(controller: ConnectedPlansViewController.nibInstance())
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
    
    private func callBlueBUttonApi() {
//        let oauthswift = OAuth2Swift(
//          consumerKey: "gjK4RnBIvCWaj1ocdYyiyKuD8qsmTnRtG2H3RGik",         // [1] Enter google app settings
//          consumerSecret: "ld9EvgboAj5Bxe1SHFXbllgsbc4ni3aYH9ct486spRZFERM4U",        // No secret required
//          authorizeUrl: "https://sandbox.bluebutton.cms.gov/v1/o/authorize/?",
//          accessTokenUrl: "https://sandbox.bluebutton.cms.gov/v1/o/token/",
//          responseType: "code"
//        )
        // create an instance and retain it
      let  oauthswift = OAuth2Swift(
            consumerKey:    "gjK4RnBIvCWaj1ocdYyiyKuD8qsmTnRtG2H3RGik",
            consumerSecret: "ld9EvgboAj5Bxe1SHFXbllgsbc4ni3aYH9ct486spRZFERM4U",
            authorizeUrl:   "https://sandbox.bluebutton.cms.gov/v1/o/authorize/?",
            accessTokenUrl: "https://sandbox.bluebutton.cms.gov/v1/o/token/",

            responseType:   "code"
        )
        let handle = oauthswift.authorize(
            withCallbackURL: "optumHealthConnect://oauth-callback",
            scope: "", state:"") { result in
            switch result {
            case .success(let (credential, response, parameters)):
              print(credential.oauthToken, response)
              // Do your request
            case .failure(let error):
              print(error.localizedDescription)
            }
        }
    }

      
    }

//MARK: Public methods
extension PayerSummaryViewController {
    
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

