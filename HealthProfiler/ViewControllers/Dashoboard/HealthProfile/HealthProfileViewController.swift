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
    @IBOutlet private var poweredby_label: UILabel!

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
            if !user.cernerConnected {
                carePlan?.questionData.removeAll()
            }
            if user.isProviderConnected && carePlan?.questionData.count ?? 0 <= 0 {
            callApiForCarePlanList()
            }
            self.navigationItem.title = user.isInsurerConnected ? "\(user.name!)  |  \(user.age!) Y  | \(user.gender!)" : "\(user.name!)"
        }
        upadateUI()
    }
    
    @IBAction func leftButtonAction(_ sender : UIButton) {
        isCernerSelected = false
         upadateUI()
        existingUserLogo_ImageView.image = UIImage(named:"southWestLogoTrans")
        healthProfiler_tableView.reloadData()

    }
    
    @IBAction func rightButtonAction(_ sender : UIButton) {
        isCernerSelected = true
         upadateUI()
        existingUserLogo_ImageView.image = UIImage(named:"adventist")
        healthProfiler_tableView.reloadData()

    }
    
    @IBAction func refreshCernerButtonAction(_ sender : UIButton) {
        HealthProfiler.authClientCerner.authorize(controller: self) { [weak self] (token, error) in
            
            if let token = token {
                
                HealthProfiler.shared.loggedInUser?.isProviderConnected = true
                print("cerner Token",token)
                self?.healthProfiler_tableView.reloadData()
                let date = Date().toString(dateFormat: "MMM dd, yyyy")
                DataCache.instance.write(string: date, forKey: "CernerConnectionTime")
                HealthProfiler.shared.loggedInUser?.cernerConnected = true

            } else {
                debugPrint(error.debugDescription)
            }
        }
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
            carePlanFooter_view.isHidden = user?.isProviderConnected ?? false ? false : true
            dataSourceCernerTeam = [HPCernerCareTeamItem(.john),HPCernerCareTeamItem(.jonson) ]
            healthProfiler_tableView.reloadData()
            
        }else {
            carePlanFooter_view.isHidden = true
//            healthProfiler_tableView.tableHeaderView = existingUserHeader_View
            left_Button.isHidden = !(user?.cernerConnected ?? false)
            right_Button.isHidden = !(user?.cernerConnected ?? false)
            refresh_Button.isHidden = !(user?.cernerConnected ?? false)
            refresh_Button.isHidden = !isCernerSelected
            poweredby_label.text = isCernerSelected ? "Powered By Cerner - Last Updated:" : "Powered By Allscripts - Last Updated:"
        }
    }
    
    private func callApi(){
        
            
            if let user = user, user.isFirstTimeUser {

            } else {
                
                callApiForAllegyList(id: "24")
                callApiForMedicationList(id: "24")
                callApiForConditionList(id: "24")
                callApiForCareTeamList(id: "24")
                callApiForGapsInCareList()
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
        

        HealthProfiler.networkManager.getCareTeamData(id: id) { [weak self] (careTeamList, error) in
            
            if let strongSelf = self {
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
        
        
        HealthProfiler.networkManager.getConditionData(id: id) { [weak self] (conditionList, error) in
            
            if let strongSelf = self {
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
//                Loader.dismiss()
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
    
    
}



extension HealthProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return user?.isFirstTimeUser == true ? 2 : 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return user?.isFirstTimeUser == true ? carePlan?.questionData.count ?? 0 : isCernerSelected ? 1 : 3
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
           return 150
        case 1:
            if user?.isFirstTimeUser == true {
                           return 85

                       } else {
                           if isCernerSelected {
                                   return 300
                            } else {
                            switch indexPath.row {
                            case 0...1:
                                return 137
                            case 2:
                                return 150
                            default:
                                break
                            }
                            }
                           }
        case 2:
            return 150

            
            
            
        default:
            break
        }
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
                let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                profilerCell.dataSourceCernerTeam = dataSourceCernerTeam
                profilerCell.datasource_medication = datasource_medicationList
                profilerCell.datasource_careteam = datasource_careteamList
                profilerCell.title_label.text = "My Care Team"
                profilerCell.cellType = 2
                profilerCell.arrowIcon.isHidden = user?.isFirstTimeUser ?? true
                profilerCell.registerCell()
                
                return profilerCell
                
//            } else {
//                if !isCernerSelected {
//                    switch indexPath.row {
//                    case 0:
//                        let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
//
//                        profilerCell.cellType = 2
//                        profilerCell.registerCell()
//                        profilerCell.title_label.text = "My Care Team"
//                        profilerCell.arrowIcon.isHidden = user?.isFirstTimeUser ?? true
//                        profilerCell.datasource_careteam = datasource_careteamList
//                        return profilerCell
//
//                    case 1...2:
//                        let allergyCell = tableView.dequeueReusableCell(withIdentifier: AllergyTableViewCell.reuseableId(), for: indexPath) as! AllergyTableViewCell
//                        allergyCell.registerCell()
//                        allergyCell.datasource_allergy = datasource_allergyList
//                        allergyCell.datasource_condition = datasource_conditionList
//                        allergyCell.title_label.text = indexPath.row == 1 ? "Allergies" : "Conditions"
//                        allergyCell.cellType = indexPath.row == 1 ? 0 : 1
//                        return allergyCell
//
//                    case 3...4:
//                        let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
//                        profilerCell.registerCell()
//                        profilerCell.datasource_medication = datasource_medicationList
//                        profilerCell.datasource_gapsInCare = datasource_gapsInCareList
//                        profilerCell.title_label.text = indexPath.row == 3 ? "Medications" : "Gaps In Care"
//                        profilerCell.arrowIcon.isHidden = true
//                        profilerCell.cellType = indexPath.row == 3 ? 1 : 0
//
//                        return profilerCell
//
//                    default: break
//                    }
//                }else {
//                    switch indexPath.row {
//                    case 0:
//                        let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
//                        profilerCell.registerCell()
//                        profilerCell.datasource_medication = datasource_medicationList
//                        profilerCell.datasource_careteam = datasource_careteamList
//                        profilerCell.title_label.text = "My Care Team"
//                        profilerCell.cellType =  2
//
//                        return profilerCell
//
//                    case 1:
//                        let cernerCell = tableView.dequeueReusableCell(withIdentifier: CernerConditionTableCell.reuseableId(), for: indexPath) as! CernerConditionTableCell
//                        cernerCell.registerCell()
//                        return cernerCell
//
//                    case 2:
//                        let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
//
//                        profilerCell.cellType = 0
//                        profilerCell.registerCell()
//                        profilerCell.title_label.text = "Gaps In Care"
//                        profilerCell.datasource_gapsInCare = datasource_gapsInCareList
//                        return profilerCell
//
//                    default: break
//                    }
//                }
//            }
        case 1:
            
            if user?.isFirstTimeUser ?? false {
                
                let careCell = tableView.dequeueReusableCell(withIdentifier: CarePlanTableCell.reuseableId(), for: indexPath) as! CarePlanTableCell
                careCell.configureCarePlanCell(item: (carePlan?.questionData[indexPath.row])! , index: indexPath.row)
                return careCell
            } else {
                if isCernerSelected {
                    let cernerCell = tableView.dequeueReusableCell(withIdentifier: CernerConditionTableCell.reuseableId(), for: indexPath) as! CernerConditionTableCell
                    cernerCell.registerCell()
                    return cernerCell
                }else {
                switch indexPath.row {
                case 0...1:
                                            let allergyCell = tableView.dequeueReusableCell(withIdentifier: AllergyTableViewCell.reuseableId(), for: indexPath) as! AllergyTableViewCell
                                            allergyCell.registerCell()
                                            allergyCell.datasource_allergy = datasource_allergyList
                                            allergyCell.datasource_condition = datasource_conditionList
                                            allergyCell.title_label.text = indexPath.row == 1 ? "Allergies" : "Conditions"
                                            allergyCell.cellType = indexPath.row == 1 ? 0 : 1
                                            return allergyCell
                case 2:
                                            let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                                            profilerCell.registerCell()
                                            profilerCell.datasource_medication = datasource_medicationList
                                            profilerCell.title_label.text = "Medications"
                                            profilerCell.arrowIcon.isHidden = true
                                            profilerCell.cellType = 1
                    
                                            return profilerCell
                default:
                    break
                }
                }

            }
            
        case 2:
            
            let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell

            profilerCell.cellType = 0
            profilerCell.registerCell()
            profilerCell.title_label.text = "Gaps In Care"
            profilerCell.datasource_gapsInCare = datasource_gapsInCareList
            profilerCell.arrowIcon.isHidden = true
            return profilerCell
            
        default:
            break
        }
        
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if user?.isFirstTimeUser ?? false {
            return section == 1 ? user?.isProviderConnected ?? false ? 133 : 0 : 0
        } else {
            return section == 1 ? 84 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if user?.isFirstTimeUser ?? false {
            return section == 1 ? user?.isProviderConnected ?? false ? header_view : nil : nil
        } else {
            
             return section == 1 ? existingUserHeader_View : nil
        }
    }
}
