//
//  ConnectedPlansViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit
import DataCache
import ScrollableSegmentedControl

class ConnectedPlansViewController: HPViewController {
    
    @IBOutlet private var tableView_Plans : UITableView!
    @IBOutlet private var providerHeader_view : UIView!
    @IBOutlet private var providerTerms_label : UILabel!
    @IBOutlet private var add_button : UIButton!
    
    @IBOutlet private var segmentedControl: ScrollableSegmentedControl!
    
    
    //private vars
    private var dataSource_InsurancePlans = [HPConnectedInsuranceItem]()
    private var dataSource_eobList = [HPEobItem]()
    
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
        setUpSegment()
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
    
    private func setUpSegment() {
        
        
        segmentedControl.segmentStyle = .textOnly
        segmentedControl.insertSegment(withTitle: "Insurance", image:  #imageLiteral(resourceName: "HomeIcon"), at: 0)
        segmentedControl.insertSegment(withTitle: "Providers", image: #imageLiteral(resourceName: "CoverageIcon"), at: 1)
        segmentedControl.insertSegment(withTitle: "Labs", image: #imageLiteral(resourceName: "profile"), at: 2)
        segmentedControl.insertSegment(withTitle: "Pharmacies", image: #imageLiteral(resourceName: "smoking"), at: 3)
        segmentedControl.insertSegment(withTitle: "Devices", image: #imageLiteral(resourceName: "smoking"), at: 3)
        
        
        segmentedControl.underlineSelected = true
        
        segmentedControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        
        // change some colors
        segmentedControl.segmentContentColor = UIColor.darkGray
        segmentedControl.selectedSegmentContentColor = UIColor.darkGray
        segmentedControl.backgroundColor = UIColor.clear
        segmentedControl.selectedSegmentIndex = isFromProvider ?? false ? 1 : 0
        
        // Turn off all segments been fixed/equal width.
        // The width of each segment would be based on the text length and font size.
        segmentedControl.fixedSegmentWidth = true
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        
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
                let date = HPDateFormatter.shared.getString(from: Date(), format: .date)
                DataCache.instance.write(string: date, forKey: "CernerConnectionTime")
                HealthProfiler.shared.loggedInUser?.cernerConnected = true
                
            } else {
                debugPrint(error.debugDescription)
            }
        }
        
    }
    
    @IBAction func blueButtonConnectAction(_ sender: UISwitch) {
        
        HealthProfiler.authClient.authorize(controller: self) { [weak self] (token, error) in
            
            if token != nil {
                
                HealthProfiler.shared.loggedInUser?.blueButtonConnected = true
                TabBarCoordinator.shared.tabBarStatus(isUserConnected:true)
                let date = HPDateFormatter.shared.getString(from: Date(), format: .date)
                DataCache.instance.write(string: date, forKey: "BlueButtonConnectionTime")
                DataCache.instance.write(string: "true", forKey: "BlueButtonConnectedWilma")
//                self?.callApiForEobList(token: token ?? "")
                
                self?.tableView_Plans.reloadData()
                
            } else {
                debugPrint(error.debugDescription)
            }
        }
    }
    
    func deletePlan() {
        
        let alrtControl = UIAlertController(title: isFromProvider ?? false ? "Delete Provider" : "Delete Plan", message: isFromProvider ?? false ? "Are you sure you want to delete the provider?" : "Are you sure you want to delete the plan?", preferredStyle: .alert)
        let no_alertAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        alrtControl.addAction(no_alertAction)
        
        let yes_alertAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            DispatchQueue.main.async {
//                AppCoordinator.shared.logout()
            }
        }
        alrtControl.addAction(yes_alertAction)
        alrtControl.preferredAction = yes_alertAction
        navigationController?.present(alrtControl, animated: true, completion: nil)
    }
    
    
}

//MARK: Private methods
private extension ConnectedPlansViewController {
    
    private func setupController() {
        
        dataSource_InsurancePlans.removeAll()
        
        dataSource_InsurancePlans = user?.isFirstTimeUser == true ? [HPConnectedInsuranceItem(.humana), HPConnectedInsuranceItem(.blueButton)] : [HPConnectedInsuranceItem(.medicare), HPConnectedInsuranceItem(.blueButton)]
        
        dataSource_provider.removeAll()
        dataSource_provider = user?.isFirstTimeUser ?? false ? user?.blueButtonConnected ?? false ? [HPConnectedProviderItem(.advent)] : [] : user?.blueButtonConnected ?? false ?  [ HPConnectedProviderItem(.southwest),  HPConnectedProviderItem(.advent)] : [ HPConnectedProviderItem(.southwest)]
        
        registerTableCell(tableView_Plans, cellClass: InsurancePlanCell.self)
        registerTableCell(tableView_Plans, cellClass: ProviderConnectedCell.self)
        self.navigationItem.hidesBackButton = false
        
        providerTerms_label.isHidden = true
        add_button.setTitle("Add Plan", for: .normal)
        
        if isFromProvider == true {
            
            tableView_Plans.tableHeaderView = providerHeader_view
            providerTerms_label.isHidden = false
            add_button.setTitle("Add Provider", for: .normal)
            //            categories_segmentControl.selectedSegmentIndex = 1
        }
        
        tableView_Plans.delegate = self
        tableView_Plans.dataSource = self
        tableView_Plans.reloadData()
        
        self.navigationItem.title = "Manage Connection"

    }
    
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
            
            providerCell.registerCell()
            providerCell.configureProviderCell(item: dataSource_provider[indexPath.row], index: indexPath.row, user: user?.isFirstTimeUser ?? false)
            if indexPath.row == 0 && user?.isFirstTimeUser == true {
                providerCell.connect_Button.addTarget(self, action: #selector(allenaConnectAction), for: .valueChanged)
            }else if indexPath.row == 1{
                providerCell.connect_Button.addTarget(self, action: #selector(allenaConnectAction), for: .valueChanged)
            }
            
            return providerCell
            
        } else {
            
            let planCell = tableView.dequeueReusableCell(withIdentifier: InsurancePlanCell.reuseableId(), for: indexPath) as! InsurancePlanCell
            planCell.registerCell()
            planCell.configureInsuranceCell(item: dataSource_InsurancePlans[indexPath.row], index: indexPath.row)
            if indexPath.row == 1 {
                planCell.activeStatus_switch.addTarget(self, action: #selector(blueButtonConnectAction), for: .valueChanged)
            }
            return planCell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        
        let closeAction = UIContextualAction(style: .normal, title:  isFromProvider ?? false ? "Delete Provider" : "Delete Plan", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.deletePlan()
            success(true)
        })
        closeAction.backgroundColor = UIColor.colorFromRGB(255, 107, 107)
        closeAction.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [closeAction])
        
    }
}
