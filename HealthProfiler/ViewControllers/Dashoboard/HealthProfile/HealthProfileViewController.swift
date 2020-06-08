//
//  HealthProfileViewController.swift
//  HealthProfiler
//

import UIKit
import DataCache

class HealthProfileViewController: HPViewController {
    
    @IBOutlet private var healthProfiler_tableView: UITableView!
    @IBOutlet private var carePlanFooter_view: UIView!
    @IBOutlet private var score_label: UILabel!
    @IBOutlet private var status_label: UILabel!
    @IBOutlet private var header_view: UIView!
    @IBOutlet private var detail_label: UILabel!
    @IBOutlet private var interoperability_label: UILabel!
    @IBOutlet private var lastUpdated_label: UILabel!
    @IBOutlet private var existingUserHeader_View: UIView!
    @IBOutlet private var left_Button: UIButton!
    @IBOutlet private var right_Button: UIButton!
    @IBOutlet private var refresh_Button: UIButton!
    @IBOutlet private var existingUserLastUpdate_Label: UILabel!
    @IBOutlet private var existingUserLogo_ImageView: UIImageView!

    var datasource_allergyList = [HPAllergiesItem]()
    var datasource_conditionList = [HPConditionItem]()
    var datasource_medicationList = [HPMedicationItem]()
    var datasource_careteamList = [HPCareTeamItem]()
    var datasource_gapsInCareList = [HPGapsInCareItem]()
    var carePlan : HPCarePlanItem?
    var dataSourceCernerTeam = [HPCernerCareTeamItem]()
    
    var isCernerSelected = Bool()
    
    
    private let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        lastUpdated_label.text = DataCache.instance.readString(forKey: "CernerConnectionTime")
        existingUserLastUpdate_Label.text = DataCache.instance.readString(forKey: "AllScriptsUpdatedDate")
        if let user = user, user.isFirstTimeUser {
            if user.isProviderConnected && dataSourceCernerTeam.count <= 0 {
            callApiForCarePlanList()
            }
            
        }
        upadateUI()
    }
    
    @IBAction func leftButtonAction(_ sender : UIButton) {
        isCernerSelected = false
        existingUserLogo_ImageView.image = UIImage(named:"southwestmedical")
        healthProfiler_tableView.reloadData()

    }
    
    @IBAction func rightButtonAction(_ sender : UIButton) {
        isCernerSelected = true
        existingUserLogo_ImageView.image = UIImage(named:"adventist")
        healthProfiler_tableView.reloadData()

    }
}


//MARK: Private methods
private extension HealthProfileViewController {
    
    private func setupController() {
        
        registerTableCell(healthProfiler_tableView, cellClass: HealthProfilerCell.self)
        registerTableCell(healthProfiler_tableView, cellClass: AllergyTableViewCell.self)
        registerTableCell(healthProfiler_tableView, cellClass: CarePlanTableCell.self)
        registerTableCell(healthProfiler_tableView, cellClass: CernerConditionTableCell.self)
        
        healthProfiler_tableView.delegate = self
        healthProfiler_tableView.dataSource = self
        isCernerSelected = false
        callApi()
    }
    
    private func upadateUI(){
        if user?.isFirstTimeUser == true {
            carePlanFooter_view.isHidden = false
            dataSourceCernerTeam = [HPCernerCareTeamItem(.john),HPCernerCareTeamItem(.jonson) ]
            healthProfiler_tableView.reloadData()
            
        }else {
            carePlanFooter_view.isHidden = true
            healthProfiler_tableView.tableHeaderView = existingUserHeader_View
            left_Button.isHidden = !(user?.cernerConnected ?? false)
            right_Button.isHidden = !(user?.cernerConnected ?? false)
            refresh_Button.isHidden = !(user?.cernerConnected ?? false)
        }
    }
    
    private func callApi(){
        
//        //fetch data from server
//        if let user = user,
//            user.blueButtonConnected {
            
            if let user = user, user.isFirstTimeUser {

            } else {
                
                callApiForAllegyList(id: "24")
                callApiForMedicationList(id: "24")
                callApiForConditionList(id: "24")
                callApiForCareTeamList(id: "24")
                callApiForGapsInCareList()
            }
//        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return user?.isFirstTimeUser == true ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return user?.isFirstTimeUser == true ?  1 : isCernerSelected ? 3 : 5
        case 1:
            return carePlan?.questionData.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            if user?.isFirstTimeUser == true {
                return 150
                
            } else {
                if isCernerSelected {
                    switch indexPath.row {
                    case 0:
                        return 150
                    case 1:
                        return 300
                    case 2:
                        return 150
                    default:
                        break
                    }
                }
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
            }
        case 1:
            return 85
            
            
        default:
            break
        }
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if user?.isFirstTimeUser ?? false {
                
                let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                profilerCell.dataSourceCernerTeam = dataSourceCernerTeam
                profilerCell.title_label.text = "My Care Team"
                profilerCell.cellType = 2
                profilerCell.registerCell()
                
                return profilerCell
                
            } else {
                if !isCernerSelected {
                switch indexPath.row {
                case 0:
                    let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                    
                    profilerCell.cellType = 2
                    profilerCell.registerCell()
                    profilerCell.title_label.text = "My Care Team"
                    profilerCell.datasource_careteam = datasource_careteamList
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
                    profilerCell.datasource_gapsInCare = datasource_gapsInCareList
                    profilerCell.title_label.text = indexPath.row == 3 ? "Medications" : "Gaps In Care"
                    profilerCell.cellType = indexPath.row == 3 ? 1 : 0
                    
                    return profilerCell
                    
                default: break
                }
                }else {
                switch indexPath.row {
                case 0:
                    let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                    profilerCell.registerCell()
                    profilerCell.datasource_medication = datasource_medicationList
                    profilerCell.datasource_careteam = datasource_careteamList
                    profilerCell.title_label.text = "My Care Team"
                    profilerCell.cellType =  2
                    
                    return profilerCell
                    
                case 1:
                    let cernerCell = tableView.dequeueReusableCell(withIdentifier: CernerConditionTableCell.reuseableId(), for: indexPath) as! CernerConditionTableCell
                    cernerCell.registerCell()
                    return cernerCell
                    
                case 2:
                    let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                    
                    profilerCell.cellType = 0
                    profilerCell.registerCell()
                    profilerCell.title_label.text = "Gaps In Care"
                    profilerCell.datasource_gapsInCare = datasource_gapsInCareList
                    return profilerCell
                    
                default: break
                }
                }
            }
        case 1:
            
            let careCell = tableView.dequeueReusableCell(withIdentifier: CarePlanTableCell.reuseableId(), for: indexPath) as! CarePlanTableCell
            careCell.configureCarePlanCell(item: (carePlan?.questionData[indexPath.row])! , index: indexPath.row)
            return careCell
            
        default:
            break
        }
        
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 1 ? 144 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return section == 1 ? header_view : nil
    }
}
