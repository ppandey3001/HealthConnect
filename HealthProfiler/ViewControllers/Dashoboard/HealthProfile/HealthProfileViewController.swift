//
//  HealthProfileViewController.swift
//  HealthProfiler
//

import UIKit
import SwiftyJSON

class HealthProfileViewController: HPViewController {
    
    @IBOutlet private var healthProfiler_tableView: UITableView!
    @IBOutlet private var carePlanFooter_view: UIView!
    @IBOutlet private var score_label: UILabel!
    @IBOutlet private var status_label: UILabel!
    @IBOutlet private var header_view: UIView!
    @IBOutlet private var detail_label: UILabel!
    @IBOutlet private var interoperability_label: UILabel!
    
    var datasource_allergyList = [HPAllergiesItem]()
    var datasource_conditionList = [HPConditionItem]()
    var datasource_medicationList = [HPMedicationItem]()
    var datasource_careteamList = [HPCareTeamItem]()
    var datasource_gapsInCareList = [HPGapsInCareItem]()
    var carePlan : HPCarePlanItem?
    
    private let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
}


//MARK: Private methods
private extension HealthProfileViewController {
    
    private func setupController() {
        
        registerTableCell(healthProfiler_tableView, cellClass: HealthProfilerCell.self)
        registerTableCell(healthProfiler_tableView, cellClass: AllergyTableViewCell.self)
        registerTableCell(healthProfiler_tableView, cellClass: CarePlanTableCell.self)
        
        healthProfiler_tableView.delegate = self
        healthProfiler_tableView.dataSource = self
        if user?.isFirstTimeUser == true {
            healthProfiler_tableView.tableHeaderView = header_view
            carePlanFooter_view.isHidden = false
        }else {
            healthProfiler_tableView.tableHeaderView = nil
            carePlanFooter_view.isHidden = true
        }
        
        callApi()
    }
    
    private func callApi(){
        
        //fetch data from server
        if let user = user,
            user.blueButtonConnected {
            
            if user.isFirstTimeUser {
                
                callApiForCarePlanList()
                
            } else {
                
                callApiForAllegyList(id: "24")
                callApiForMedicationList(id: "24")
                callApiForConditionList(id: "24")
                callApiForCareTeamList(id: "24")
                callApiForGapsInCareList()
            }
        }
    }
    
    private func carePlanReceived(plan: HPCarePlanItem) {
        
        carePlan = plan
        status_label.text = carePlan?.status
        interoperability_label.text = carePlan?.interpretation
        detail_label.text = carePlan?.careDescription
        score_label.text = carePlan?.finalscore
        healthProfiler_tableView.reloadData()
        
    }
    
}

//MARK: - API interaction -
extension HealthProfileViewController {
    
    private func callApiForAllegyList(id : String) {
        
        Loader.show()
        
        HealthProfiler.networkManager.getAllergyData(id: id) { [weak self] (allergyList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                strongSelf.datasource_allergyList.removeAll()
                if let allergyList = allergyList {
                    strongSelf.datasource_allergyList = allergyList
                    strongSelf.healthProfiler_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForCareTeamList(id : String) {
        
        Loader.show()
        
        HealthProfiler.networkManager.getCareTeamData(id: id) { [weak self] (careTeamList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                strongSelf.datasource_careteamList.removeAll()
                if let careList = careTeamList {
                    strongSelf.datasource_careteamList = careList
                    strongSelf.healthProfiler_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForConditionList(id : String) {
        
        Loader.show()
        
        HealthProfiler.networkManager.getConditionData(id: id) { [weak self] (conditionList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                strongSelf.datasource_conditionList.removeAll()
                if let conditionList = conditionList {
                    strongSelf.datasource_conditionList = conditionList
                    strongSelf.healthProfiler_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForMedicationList(id : String) {
        
        Loader.show()
        
        HealthProfiler.networkManager.getMedicationData(id: id) { [weak self] (medicationList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                strongSelf.datasource_medicationList.removeAll()
                if let medicationList = medicationList {
                    strongSelf.datasource_medicationList = medicationList
                    strongSelf.healthProfiler_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForGapsInCareList() {
        
        Loader.show()
        
        HealthProfiler.networkManager.getGapsInCareData() { [weak self] (gapsInCareList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                strongSelf.datasource_gapsInCareList.removeAll()
                if let gapsInCareList = gapsInCareList {
                    strongSelf.datasource_gapsInCareList = gapsInCareList
                    strongSelf.healthProfiler_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForCarePlanList() {
        
        Loader.show()
        
        HealthProfiler.networkManager.getCarePlanData() { [weak self] (carePlanList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                if let carePlanList = carePlanList {
                    strongSelf.carePlanReceived(plan: carePlanList)
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
}



extension HealthProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return user?.isFirstTimeUser == true ? carePlan?.questionData.count ?? 0 : 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if user?.isFirstTimeUser == true {
            return 85
        } else {
            switch indexPath.row {
            case 0:
                return 150
            case 1...2:
                return 100
            case 3:
                return 150
            case 4:
                return 150
            default:
                break
            }
            return 90
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if user?.isFirstTimeUser == true {
            
            let careCell = tableView.dequeueReusableCell(withIdentifier: CarePlanTableCell.reuseableId(), for: indexPath) as! CarePlanTableCell
            careCell.configureCarePlanCell(item: (carePlan?.questionData[indexPath.row])! , index: indexPath.row)
            return careCell
            
        } else {
            
            switch indexPath.row {
            case 0:
                let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                
                profilerCell.cellType = 0
                profilerCell.registerCell()
                profilerCell.title_label.text = "Gaps In Care"
                profilerCell.datasource_gapsInCare = datasource_gapsInCareList
                return profilerCell
                
            case 1...2:
                let allergyCell = tableView.dequeueReusableCell(withIdentifier: AllergyTableViewCell.reuseableId(), for: indexPath) as! AllergyTableViewCell
                allergyCell.registerCell()
                allergyCell.datasource_allergy = datasource_allergyList
                allergyCell.datasource_condition = datasource_conditionList
                allergyCell.title_label.text = indexPath.row == 1 ? "Allergies" : "Conditions"
                allergyCell.cellType = indexPath.row == 1 ? 0 : 1
                return allergyCell
                
            case 3...4:
                let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                profilerCell.registerCell()
                profilerCell.datasource_medication = datasource_medicationList
                profilerCell.datasource_careteam = datasource_careteamList
                profilerCell.title_label.text = indexPath.row == 3 ? "Medications" : "My Care Team"
                profilerCell.cellType = indexPath.row == 3 ? 1 : 2
                
                return profilerCell
                
            default: break
            }
        }
        
        return UITableViewCell()
    }
}
