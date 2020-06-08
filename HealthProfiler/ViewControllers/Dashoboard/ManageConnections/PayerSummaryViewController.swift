//
//  PayerSummaryViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class PayerSummaryViewController: HPViewController {
    
    @IBOutlet private var view_summary : UIView!
    @IBOutlet private var view_brief : UIView!
    @IBOutlet private var label_healthplan : UILabel!
    @IBOutlet private var tableView_Summary : UITableView!
    
    private var dataSource_eobList = [HPEobItem]()
    private let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        container()?.showBrandingBar(true)
        
    }
    
    @IBAction func payerDetailAction(_ sender : UIButton) {
        
        view_brief.isHidden = true
    }
    
    @IBAction func blueButtonAction(_ sender : UIButton) {
        
        HealthProfiler.authClient.authorize(controller: self) { [weak self] (token, error) in
            
            if let token = token {
                
                HealthProfiler.shared.loggedInUser?.blueButtonConnected = true
                
                TabBarCoordinator.shared.tabBarStatus(isUserConnected:true)
                self?.push(controller: ConnectedPlansViewController.nibInstance())
                self?.callApiForEobList(token: token)
            } else {
                debugPrint(error.debugDescription)
            }
        }
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
        
        HealthProfiler.shared.loggedInUser?.isInsurerConnected = true
        
        registerTableCell(tableView_Summary, cellClass: SummaryBenefitCell.self)
        
        tableView_Summary.delegate = self
        tableView_Summary.dataSource = self
        tableView_Summary.reloadData()
    }
    
    @objc private func showDetailsAction(_ sender : UIButton){
        
        let briefView = tableView_Summary.viewWithTag(sender.tag)
        briefView?.isHidden = true
        tableView_Summary.reloadData()
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


//UITableViewDelegate, UITableViewDataSource
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
