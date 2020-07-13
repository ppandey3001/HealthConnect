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
    @IBOutlet private var lastUpdatedCerner_label: UILabel!
    @IBOutlet private var lastUpdatedAllScript_label: UILabel!
    @IBOutlet private var sectionHeader_View: UIView!
    @IBOutlet private var carePlanHeader_View: UIView!
    @IBOutlet private var cerner_View: UIView!
    @IBOutlet private var allscript_View: UIView!
    @IBOutlet private var historyButton: UIButton!
    
    @IBOutlet private var leftarrowIcon: UIImageView!
    @IBOutlet private var rightarrowIcon: UIImageView!

    
    @IBOutlet private var segment_collection : UICollectionView!

    var selectedSegmentType : Int = 0

    var datasource_allergyList = [HPAllergiesItem]()
    var datasource_segment = [HPSegmentItem]()
    var datasource_conditionList = [HPConditionItem]()
    var datasource_medicationList = [HPMedicationItem]()
    var datasource_careteamList = [HPCareTeamItem]()
    var datasource_gapsInCareList = [HPGapsInCareItem]()
    
    var datasource_StaticallergyList = [HPAllergyItem]()
    var datasource_StaticconditionList = [HPHistoryConditionItem]()
    var datasource_StaticmedicationList = [HPMedicationsItem]()
    var datasource_StaticgapsInCareList = [HPGapsItem]()
    var dataSourceCernerTeam = [HPCernerCareTeamItem]()

    
    var carePlan : HPCarePlanItem?
    
    var isCernerSelected = Bool()
    var iscareplanApiFailed = Bool()
    var isconditionApiFailed = Bool()
    var isallegrgyApiFailed = Bool()
    var isgapsApiFailed = Bool()
    var ismedicationApiFailed = Bool()

    
    private let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        lastUpdated_label.text = "Last updated: " + (DataCache.instance.readString(forKey: "CernerConnectionTime") ?? "")
        lastUpdatedCerner_label.text = (DataCache.instance.readString(forKey: "CernerConnectionTime"))
        if let user = user, user.isFirstTimeUser {
            if !user.cernerConnected {
                carePlan?.questionData.removeAll()
            }
            if user.isProviderConnected && carePlan?.questionData.count ?? 0 <= 0 {
            callApiForCarePlanList()
            }
        }
        upadateUI()
    }
    
    @IBAction func leftButtonAction(_ sender : UIButton) {
        
        isCernerSelected = false
         upadateUI()

        leftarrowIcon.isHidden = false
        rightarrowIcon.isHidden = true
        healthProfiler_tableView.reloadData()

    }
    
    @IBAction func rightButtonAction(_ sender : UIButton) {
        
        isCernerSelected = true
         upadateUI()
        leftarrowIcon.isHidden = true
        rightarrowIcon.isHidden = false

        healthProfiler_tableView.reloadData()

    }
    
    @IBAction func historyButtonAction(_ sender : UIButton) {
        

        let history = HIstoryViewController.nibInstance()
        history.datasource_allergyList = datasource_allergyList
        history.datasource_medicationList = datasource_medicationList
        history.datasource_gapsInCareList = datasource_gapsInCareList
        history.datasource_StaticmedicationList = datasource_StaticmedicationList
        history.datasource_StaticallergyList = datasource_StaticallergyList
        history.datasource_StaticgapsInCareList = datasource_StaticgapsInCareList
        push(controller: history)
        
    }
    
    @IBAction func refreshCernerButtonAction(_ sender : UIButton) {
        
        HealthProfiler.authClientCerner.authorize(controller: self) { [weak self] (token, error) in
            
            if let token = token {
                
                HealthProfiler.shared.loggedInUser?.isProviderConnected = true
                print("cerner Token",token)
                self?.healthProfiler_tableView.reloadData()
                let date = HPDateFormatter.shared.getString(from: Date(), format: .date)
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
        registerTableCell(healthProfiler_tableView, cellClass: CareTeamSectionTableCell.self)
        registerCollectionCell(segment_collection, cellClass: SegmentCollectionCell.self)

        
        datasource_segment = [HPSegmentItem(.conditions), HPSegmentItem(.allergies), HPSegmentItem(.medications), HPSegmentItem(.gapsInCare)]
        
        datasource_StaticallergyList = [HPAllergyItem(.glucophage), HPAllergyItem(.heparins), HPAllergyItem(.inhibitors), HPAllergyItem(.iodinated), HPAllergyItem(.keflex), HPAllergyItem(.lisinopril), HPAllergyItem(.morphine), HPAllergyItem(.nsaid)]
        datasource_StaticconditionList = [HPHistoryConditionItem(.childVisit), HPHistoryConditionItem(.acute), HPHistoryConditionItem(.angina), HPHistoryConditionItem(.pneumonia), HPHistoryConditionItem(.diabeties), HPHistoryConditionItem(.urinary), HPHistoryConditionItem(.hypertension)]
        datasource_StaticmedicationList = [HPMedicationsItem(.amiodrane)]
        datasource_StaticgapsInCareList = [HPGapsItem(.diabetes), HPGapsItem(.colorectal), HPGapsItem(.fraility)]

        healthProfiler_tableView.delegate = self
        healthProfiler_tableView.dataSource = self
        segment_collection.delegate = self
        segment_collection.dataSource = self
        isCernerSelected = false
        
        iscareplanApiFailed = false
        isconditionApiFailed = false
        isallegrgyApiFailed = false
        isgapsApiFailed = false
        ismedicationApiFailed = false

        historyButton.isHidden = user?.isFirstTimeUser ?? false
        
        leftarrowIcon.isHidden = false
        rightarrowIcon.isHidden = true
        
        let date = HPDateFormatter.shared.getString(from: Date(), format: .date)
        lastUpdatedAllScript_label.text = "Last updated: " + date

        segment_collection.reloadData()
        callApi()
    }
    
    private func upadateUI(){
        
        cerner_View.isHidden = !(user?.cernerConnected ?? false)
        
        if user?.isFirstTimeUser == true {
            carePlanFooter_view.isHidden = user?.isProviderConnected ?? false ? false : true
            dataSourceCernerTeam = [HPCernerCareTeamItem(.john),HPCernerCareTeamItem(.jonson) ]
            healthProfiler_tableView.reloadData()
            
        }else {
            dataSourceCernerTeam = [HPCernerCareTeamItem(.peter), HPCernerCareTeamItem(.vinya), HPCernerCareTeamItem(.karen), HPCernerCareTeamItem(.dave), HPCernerCareTeamItem(.barbara)]
            carePlanFooter_view.isHidden = true
            historyButton.isEnabled = user?.cernerConnected ?? false
            historyButton.alpha = user?.cernerConnected ?? false ? 1.0 : 0.6

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
        healthProfiler_tableView.reloadData()

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
                    self?.isallegrgyApiFailed = true
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
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
                    self?.iscareplanApiFailed = true
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
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
                    self?.isconditionApiFailed = true
                    strongSelf.healthProfiler_tableView.reloadData()
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
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
                    self?.ismedicationApiFailed = true
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
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
                    self?.iscareplanApiFailed = true
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
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
                    self?.isgapsApiFailed = true
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    
}



extension HealthProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return user?.isFirstTimeUser == true ? 2 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if user?.isFirstTimeUser == true {
                return carePlan?.questionData.count ?? 0
                
            } else {

                switch selectedSegmentType {
                case 0:
                    return isCernerSelected ? 1 : isconditionApiFailed ? datasource_StaticconditionList.count : datasource_conditionList.count
                case 1:
                    return isCernerSelected ? 0 : isallegrgyApiFailed ? datasource_StaticallergyList.count : datasource_allergyList.count
                case 2:
                    return isCernerSelected ? 0 : ismedicationApiFailed ? datasource_StaticmedicationList.count :  datasource_medicationList.count
                case 3:
                    return  isgapsApiFailed ? datasource_StaticgapsInCareList.count : datasource_gapsInCareList.count
                default:
                    break
                }
                //                }
            }
        default:
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return user?.isFirstTimeUser ?? false ? 180 : 265
        case 1:
            if user?.isFirstTimeUser == true {
                return 75
                
            } else {
                if isCernerSelected {
                    switch selectedSegmentType {
                    case 0:
                        return 300
                    case 3:
                        return 80
                    default:
                        break
                    }
                } else {
                    switch selectedSegmentType {
                    case 0...1:
                        return 60
                    case 2...3:
                        return 80
                    default:
                        break
                    }
                }
            }
            
        default:
            break
        }
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let careTeamCell = tableView.dequeueReusableCell(withIdentifier: CareTeamSectionTableCell.reuseableId(), for: indexPath) as! CareTeamSectionTableCell
            careTeamCell.registerCell()
            careTeamCell.datasource_careteamList = datasource_careteamList
            careTeamCell.dataSourceCernerTeam = dataSourceCernerTeam
            
            return careTeamCell
        case 1:
            
            if user?.isFirstTimeUser ?? false {
                
                let careCell = tableView.dequeueReusableCell(withIdentifier: CarePlanTableCell.reuseableId(), for: indexPath) as! CarePlanTableCell
                careCell.configureCarePlanCell(item: (carePlan?.questionData[indexPath.row])! , index: indexPath.row)
                return careCell
            } else {
                if isCernerSelected {
                    switch selectedSegmentType {
                    case 0:
                        let cernerCell = tableView.dequeueReusableCell(withIdentifier: CernerConditionTableCell.reuseableId(), for: indexPath) as! CernerConditionTableCell
                        cernerCell.registerCell()
                        return cernerCell
                        
                    case 3:
                        
                        let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                        
                        profilerCell.configureGapsInCareCell(item: datasource_gapsInCareList[indexPath.row])
                        
                        return profilerCell
                        
                    default:
                        break
                    }
                    
                }else {
                    switch selectedSegmentType {
                    case 0:
                        let allergyCell = tableView.dequeueReusableCell(withIdentifier: AllergyTableViewCell.reuseableId(), for: indexPath) as! AllergyTableViewCell
                        if ismedicationApiFailed {
                            allergyCell.configureStaticConditionCareCell(item: datasource_StaticconditionList[indexPath.row])
                        }else {
                            
                        allergyCell.configureConditionCareCell(item: datasource_conditionList[indexPath.row])
                        }
                        
                        return allergyCell
                    case 1:
                        let allergyCell = tableView.dequeueReusableCell(withIdentifier: AllergyTableViewCell.reuseableId(), for: indexPath) as! AllergyTableViewCell
                        
                        if isallegrgyApiFailed {
                            
                            allergyCell.configureStaticAllergyCell(item: datasource_StaticallergyList[indexPath.row])
                        }else {
                            
                        allergyCell.configureAllergyCell(item: datasource_allergyList[indexPath.row])
                        }
                        
                        return allergyCell
                    case 2:
                        let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                        
                        if ismedicationApiFailed {
                            
                            profilerCell.configureStaticMedicationCell(item: datasource_StaticmedicationList[indexPath.row])
                        }else {
                            
                        profilerCell.configureMedicationCell(item: datasource_medicationList[indexPath.row])
                        }
                        return profilerCell
                        
                    case 3:
                        
                        let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                        
                        if isgapsApiFailed {
                            
                            profilerCell.configureStaticGapsInCareCell(item: datasource_StaticgapsInCareList[indexPath.row])
                        }else {
                            
                        profilerCell.configureGapsInCareCell(item: datasource_gapsInCareList[indexPath.row])
                        }
                        
                        return profilerCell
                        
                    default:
                        break
                    }
                }
                
            }
            
        default:
            break
        }
        
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if user?.isFirstTimeUser ?? false {
            return section == 1 ? user?.isProviderConnected ?? false ? 133 : 0 : 55
        } else {
            return section == 0 ? 55 : 352
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if user?.isFirstTimeUser ?? false {
            return section == 1 ? user?.isProviderConnected ?? false ? header_view : nil : carePlanHeader_View
        } else {
            
            return section == 1 ? sectionHeader_View : carePlanHeader_View
            
        }
    }
}

extension HealthProfileViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datasource_segment.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 78)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cernerCell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionCell.reuseableId(), for: indexPath) as! SegmentCollectionCell
        
        cernerCell.selectedSegment = selectedSegmentType
        cernerCell.configureSegments(item: datasource_segment[indexPath.row], index : indexPath.row)
        
        return cernerCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedSegmentType = indexPath.row
        healthProfiler_tableView.reloadData()
        segment_collection.reloadData()
    }
    
    
}
