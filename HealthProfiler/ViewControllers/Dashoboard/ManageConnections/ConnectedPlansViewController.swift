//
//  ConnectedPlansViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class ConnectedPlansViewController: HPViewController {
    
    @IBOutlet private var tableView_Plans : UITableView!
    @IBOutlet private var providerHeader_view : UIView!
    @IBOutlet private var insuranceHeader_view : UIView!
    @IBOutlet private var providerTerms_label : UILabel!
    @IBOutlet private var categories_segmentControl : UISegmentedControl!
    @IBOutlet private var add_button : UIButton!
    
    private var dataSource_InsurancePlans = [HPConnectedInsuranceItem]()
    private var dataSource_provider = [HPConnectedProviderItem]()
    
    let user = HealthProfiler.shared.loggedInUser
    
    var isFromProvider : Bool?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    @IBAction func allenaConnectAction(_ sender: UIButton){
        let allena = AllenaHealthViewController.nibInstance()
        allena.dataSource_provider = dataSource_provider
        push(controller: allena)
    }
}

//MARK: Private methods
private extension ConnectedPlansViewController {
    
    private func setupController() {
        
        dataSource_InsurancePlans.removeAll()

        dataSource_InsurancePlans = user?.isFirstTimeUser == true ? [HPConnectedInsuranceItem(.humana), HPConnectedInsuranceItem(.blueButton)] : [HPConnectedInsuranceItem(.medicare), HPConnectedInsuranceItem(.blueButton)]
        
        dataSource_provider.removeAll()
        dataSource_provider = user?.isFirstTimeUser == true ? [HPConnectedProviderItem(.epicSystem), HPConnectedProviderItem(.cemer)] : [ HPConnectedProviderItem(.cemer), HPConnectedProviderItem(.allScripts)]
        
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

//MARK: Public methods
extension ConnectedPlansViewController {
    
}

extension ConnectedPlansViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isFromProvider == true ? dataSource_provider.count : dataSource_InsurancePlans.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFromProvider == true {
            
            let providerCell = tableView.dequeueReusableCell(withIdentifier: ProviderConnectedCell.reuseableId(), for: indexPath) as! ProviderConnectedCell
            providerCell.configureProviderCell(item: dataSource_provider[indexPath.row], index: indexPath.row)
            if indexPath.row == 1 {
                providerCell.connect_Button.addTarget(self, action: #selector(allenaConnectAction), for: .touchUpInside)
            }
            
            return providerCell
            
        } else {
            let planCell = tableView.dequeueReusableCell(withIdentifier: InsurancePlanCell.reuseableId(), for: indexPath) as! InsurancePlanCell
            
            planCell.configureInsuranceCell(item: dataSource_InsurancePlans[indexPath.row], index: indexPath.row)
            
            return planCell
        }
    }
}
