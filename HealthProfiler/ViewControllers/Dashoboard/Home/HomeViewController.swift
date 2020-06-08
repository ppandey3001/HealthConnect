//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit
import DataCache

class HomeViewController: HPViewController {
    
    @IBOutlet private var temp_label : UILabel!
    @IBOutlet private var heartRate_label : UILabel!
    @IBOutlet private var bp_label : UILabel!
    @IBOutlet private var bmi_label : UILabel!
    @IBOutlet private var height_label : UILabel!
    @IBOutlet private var weight_label : UILabel!
    @IBOutlet private var lastUpdated_label : UILabel!
    @IBOutlet private var recent_tableView : UITableView!
    @IBOutlet private var sectionHeader_view : UIView!
    @IBOutlet private var search_textField : UITextField!

    private var userVital: HPVitalsItem?
    private var dataSource_recentVisit = [HPRecentVisitItem]()
    private var dataSource_costEstimatorList = [HPCostEstimatorList]()
    private var user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func searchButtonAction(_ sender : UIButton) {
        view.endEditing(true)
        
        if search_textField.text?.lowercased() == "urology" {
            callApiForCostEstimatorList()
        }
    }
}

//MARK: Private methods
private extension HomeViewController {
    
    private func setupController() {
        
        registerTableCell(recent_tableView, cellClass: REcentVisitTableCell.self)
        registerTableCell(recent_tableView, cellClass: CostListTableCell.self)

        recent_tableView.delegate = self
        recent_tableView.dataSource = self
        recent_tableView.reloadData()
        addProfileButton()
        
        callApiForVitalsList()
        callApiForRecentVisitList()
    }
    
    private func userVitalReceived(vital: HPVitalsItem) {
        
        userVital = vital
        temp_label.text = userVital?.bodytemprature
        heartRate_label.text = (userVital?.heartrate ?? "N/A") + " BPM"
        bp_label.text = userVital?.bloodpressure
        bmi_label.text = userVital?.bmi
        height_label.text = userVital?.height
        weight_label.text = userVital?.weight
        lastUpdated_label.text = DataCache.instance.readString(forKey: "AllScriptsUpdatedDate")
    }
}

//MARK: - API interaction -
extension HomeViewController {
    
    private func callApiForVitalsList() {
        
        Loader.show()
        
        HealthProfiler.networkManager.getVitalData(id: "24") { [weak self] (vitalItem, error) in
            
            if let strongSelf = self {
                
                if let vitalItem = vitalItem {
                    let date = Date().dateString("MMM dd, yyyy")
                    DataCache.instance.write(string: date, forKey: "AllScriptsUpdatedDate")
                    strongSelf.userVitalReceived(vital: vitalItem)
                    
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForRecentVisitList() {
        
        HealthProfiler.networkManager.getRecentVisitList(id: "24") { [weak self] (visitList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                
                if let visitList = visitList {
                    strongSelf.dataSource_recentVisit = visitList
                    strongSelf.recent_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForCostEstimatorList() {
        
        HealthProfiler.networkManager.getCostEstimatorResultList(id: "208800000X") { [weak self] (estimatorList, error) in
            Loader.show()

            if let strongSelf = self {
                
                if let estimatorList = estimatorList {
                    Loader.dismiss()
                    strongSelf.dataSource_costEstimatorList = estimatorList
                    strongSelf.recent_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource -
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? ((dataSource_recentVisit.count > 0) ? 1 : 0) : dataSource_costEstimatorList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 194 : 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0 :
            let visitsCell = tableView.dequeueReusableCell(withIdentifier: REcentVisitTableCell.reuseableId(), for: indexPath) as! REcentVisitTableCell
            visitsCell.registerCell()
            visitsCell.dataSource_recentVisit = dataSource_recentVisit
            return visitsCell
            
        case 1:
            let costCell = tableView.dequeueReusableCell(withIdentifier: CostListTableCell.reuseableId(), for: indexPath) as! CostListTableCell
            costCell.configureCostListCell(item: dataSource_costEstimatorList[indexPath.row])
            return costCell

            
        default:
        break
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 1 ? sectionHeader_view : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 151 : 0
    }
}
