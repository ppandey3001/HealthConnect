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
    @IBOutlet private var providerTerms_label : UILabel!
    @IBOutlet private var add_button : UIButton!
    
    private var dataSource_InsurancePlans = [HPConnectedInsuranceItem]()
    private var dataSource_provider = [HPConnectedProviderItem]()
    
    var isFromProvider : Bool?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
}

//MARK: Private methods
private extension ConnectedPlansViewController {
    
    private func setupController() {
                
        dataSource_InsurancePlans.removeAll()
        dataSource_InsurancePlans = [HPConnectedInsuranceItem(.medicare), HPConnectedInsuranceItem(.blueButton)]
        
        dataSource_provider.removeAll()
        dataSource_provider = [HPConnectedProviderItem(.epicSystem), HPConnectedProviderItem(.cemer), HPConnectedProviderItem(.allScripts)]
        
        registerTableCellAndNib(tableView_Plans, tableCellClass: InsurancePlanCell.self, cellID: InsurancePlanCell.reuseIdentifier(), nibName: "InsurancePlanCell")
        registerTableCellAndNib(tableView_Plans, tableCellClass: ProviderConnectedCell.self, cellID: ProviderConnectedCell.reuseIdentifier(), nibName: "ProviderConnectedCell")
        
        
        tableView_Plans.delegate = self
        tableView_Plans.dataSource = self
        
        if isFromProvider == true {
            
            tableView_Plans.tableHeaderView = providerHeader_view
            providerTerms_label.isHidden = false
            add_button.setTitle("Add Provider", for: .normal)
        }
        
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
        
        let planCell = tableView.dequeueReusableCell(withIdentifier: InsurancePlanCell.reuseIdentifier(), for: indexPath) as! InsurancePlanCell
        //        let providerCell = tableView.dequeueReusableCell(withIdentifier: ProviderConnectedCell.reuseIdentifier(), for: indexPath) as! ProviderConnectedCell
        //
        //        if isFromProvider == true {
        //
        //            providerCell.configureProviderCell(item: dataSource_provider[indexPath.row], index: indexPath.row)
        //
        //            return providerCell
        //
        //        }else {
        planCell.configureInsuranceCell(item: dataSource_InsurancePlans[indexPath.row], index: indexPath.row)
        
        return planCell
        
        
        //        }
        
    }
}
