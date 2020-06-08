//
//  ConnectedPlansViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit
import DataCache

class ConnectedPlansViewController: HPViewController {
    
    @IBOutlet private var tableView_Plans : UITableView!
    @IBOutlet private var providerHeader_view : UIView!
    @IBOutlet private var insuranceHeader_view : UIView!
    @IBOutlet private var providerTerms_label : UILabel!
    @IBOutlet private var categories_segmentControl : UISegmentedControl!
    @IBOutlet private var add_button : UIButton!
    
    //private vars
    private var dataSource_InsurancePlans = [HPConnectedInsuranceItem]()
    private let user = HealthProfiler.shared.loggedInUser
    
    //public vars
    var isFromProvider : Bool?
    var dataSource_provider = [HPConnectedProviderItem]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        container()?.showBrandingBar(true)
        tableView_Plans.reloadData()
    }
    
    @IBAction func changeCategories_segmentControl(_ sender : UISegmentedControl){
        
        switch sender.selectedSegmentIndex {
        case 0:
            isFromProvider = false
            
        case 1:
            isFromProvider = true
            
        default:
            break
        }
        
        setupController()
    }
    
    @IBAction func allenaConnectAction(_ sender: UIButton) {
        
        HealthProfiler.authClientCerner.authorize(controller: self) { [weak self] (token, error) in
            
            if let token = token {
                
                HealthProfiler.shared.loggedInUser?.isProviderConnected = true
                print("cerner Token",token)
                self?.tableView_Plans.reloadData()
                let date = Date().toString(dateFormat: "MMM dd, yyyy")
                DataCache.instance.write(string: date, forKey: "CernerConnectionTime")
                HealthProfiler.shared.loggedInUser?.cernerConnected = true

            } else {
                debugPrint(error.debugDescription)
            }
        }

    }
    
    @IBAction func blueButtonConnectAction(_ sender: UIButton) {
        
        HealthProfiler.authClient.authorize(controller: self) { [weak self] (token, error) in
            
            if token != nil {
                
                HealthProfiler.shared.loggedInUser?.blueButtonConnected = true
                TabBarCoordinator.shared.tabBarStatus(isUserConnected:true)
                let date = Date().toString(dateFormat: "MMM dd, yyyy")
                DataCache.instance.write(string: date, forKey: "BlueButtonConnectionTime")
                DataCache.instance.write(string: "true", forKey: "BlueButtonConnectedWilma")
                self?.tableView_Plans.reloadData()

            } else {
                debugPrint(error.debugDescription)
            }
        }
    }
    
    
}

//MARK: Private methods
private extension ConnectedPlansViewController {
    
    private func setupController() {
        
        dataSource_InsurancePlans.removeAll()
        
        dataSource_InsurancePlans = user?.isFirstTimeUser == true ? [HPConnectedInsuranceItem(.humana), HPConnectedInsuranceItem(.blueButton)] : [HPConnectedInsuranceItem(.medicare), HPConnectedInsuranceItem(.blueButton)]
        
        dataSource_provider.removeAll()
        dataSource_provider = user?.isFirstTimeUser ?? false ? user?.blueButtonConnected ?? false ? [HPConnectedProviderItem(.advent)] : [] : user?.blueButtonConnected ?? false ?  [ HPConnectedProviderItem(.southwest),  HPConnectedProviderItem(.methodist)] : [ HPConnectedProviderItem(.southwest)]
        
        registerTableCell(tableView_Plans, cellClass: InsurancePlanCell.self)
        registerTableCell(tableView_Plans, cellClass: ProviderConnectedCell.self)
        
        tableView_Plans.tableHeaderView = insuranceHeader_view
        providerTerms_label.isHidden = true
        add_button.setTitle("Add Plan", for: .normal)
        
        if isFromProvider == true {
            
            tableView_Plans.tableHeaderView = providerHeader_view
            providerTerms_label.isHidden = false
            add_button.setTitle("Add Provider", for: .normal)
            categories_segmentControl.selectedSegmentIndex = 1
        }
        
        tableView_Plans.delegate = self
        tableView_Plans.dataSource = self
        tableView_Plans.reloadData()
    }
}


//UITableViewDelegate, UITableViewDataSource
extension ConnectedPlansViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isFromProvider == true ? dataSource_provider.count : dataSource_InsurancePlans.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isFromProvider == true ? 169 : 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFromProvider == true {
            
            let providerCell = tableView.dequeueReusableCell(withIdentifier: ProviderConnectedCell.reuseableId(), for: indexPath) as! ProviderConnectedCell
            providerCell.configureProviderCell(item: dataSource_provider[indexPath.row], index: indexPath.row, user: user?.isFirstTimeUser ?? false)
            if indexPath.row == 0 && user?.isFirstTimeUser == true {
                providerCell.connect_Button.addTarget(self, action: #selector(allenaConnectAction), for: .touchUpInside)
            }else if indexPath.row == 1{
                providerCell.connect_Button.addTarget(self, action: #selector(allenaConnectAction), for: .touchUpInside)
            }
            
            return providerCell
            
        } else {
            
            let planCell = tableView.dequeueReusableCell(withIdentifier: InsurancePlanCell.reuseableId(), for: indexPath) as! InsurancePlanCell
            
            planCell.configureInsuranceCell(item: dataSource_InsurancePlans[indexPath.row], index: indexPath.row)
            if indexPath.row == 1 {
                planCell.activeStatus_Button.addTarget(self, action: #selector(blueButtonConnectAction), for: .touchUpInside)
            }
            return planCell
        }
    }
}
