//
//  HealthProfileViewController.swift
//  HealthProfiler
//

import UIKit
import SwiftyJSON

class HealthProfileViewController: HPViewController {
    
    @IBOutlet private var healthProfiler_tableView: UITableView!
    
    var datasource_allergy = [HPAllergiesItem]()
    var allergyResult = HPAllergiesItem()
    
    var datasource_conditions = [HPConditionItem]()
    var conditionResult = HPConditionItem()
    var datasource_medication = [HPMedicationItem]()
    var medicationResult = HPMedicationItem()
    var datasource_careteam = [HPCareTeamItem]()
    var careteamResult = HPCareTeamItem()
    var datasource_gapsInCare = [HPGapsInCareItem]()
    var gapsInCareResult = HPGapsInCareItem()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
        callApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
}


//MARK: Private methods
private extension HealthProfileViewController {
    
    private func setupController() {
        
        registerTableCell(healthProfiler_tableView, cellClass: HealthProfilerCell.self)
        registerTableCell(healthProfiler_tableView, cellClass: AllergyTableViewCell.self)
        
        healthProfiler_tableView.delegate = self
        healthProfiler_tableView.dataSource = self
    }
    
    func callApi(){
        
        callApiForAllegyList()
        callApiForMedicationList()
        callApiForConditionsList()
        callApiForCareTeamList()
        callApiForGapsInCareList()
    }
    
    func callApiForAllegyList(){
        Loader.show()
        let params = [
            "id" : "24",
        ]
        ApiCallManager.sharedInstance.fetchDataFromRemote(params: params, methodType: .get, apiName: "AllergyIntolerance?") { (response, error) in
            print(JSON(response as Any))
            if response != nil {
                let responseData = JSON(response as Any)
                print("getting response", responseData)
                for obj in responseData.rawValue as! Array<Dictionary<String, Any>?>  {
                    self.datasource_allergy.append(self.allergyResult.getAllergyDataFrom(dataDict: (obj )!))
                }
                self.healthProfiler_tableView.reloadData()
            }
        }
    }
    
    func callApiForConditionsList(){
        let params = [
            "id" : "24",
        ]
        ApiCallManager.sharedInstance.fetchDataFromRemote(params: params, methodType: .get, apiName: "Condition?") { (response, error) in
            print(JSON(response as Any))
            if response != nil {
                let responseData = JSON(response as Any)
                print("getting response", responseData)
                for obj in responseData.rawValue as! Array<Dictionary<String, Any>?>  {
                    self.datasource_conditions.append(self.conditionResult.getConditionDataFrom(dataDict: (obj )!))
                }
                self.healthProfiler_tableView.reloadData()
            }
        }
    }
    
    func callApiForMedicationList(){
        let params = [
            "id" : "24",
        ]
        ApiCallManager.sharedInstance.fetchDataFromRemote(params: params, methodType: .get, apiName: "Medication?") { (response, error) in
            print(JSON(response as Any))
            if response != nil {
                let responseData = JSON(response as Any)
                print("getting response", responseData)
                for obj in responseData.rawValue as! Array<Dictionary<String, Any>?>  {
                    self.datasource_medication.append(self.medicationResult.getMedicationDataFrom(dataDict: (obj )!))
                }
                self.healthProfiler_tableView.reloadData()
            }
        }
    }
    
    func callApiForCareTeamList(){
        let params = [
            "id" : "24",
        ]
        ApiCallManager.sharedInstance.fetchDataFromRemote(params: params, methodType: .get, apiName: "CareTeam?") { (response, error) in
            print(JSON(response as Any))
            if response != nil {
                let responseData = JSON(response as Any)
                for obj in responseData.rawValue as! Array<Dictionary<String, Any>?>  {
                    self.datasource_careteam.append(self.careteamResult.getCareTeamDataFrom(dataDict: (obj )!))
                }
                self.healthProfiler_tableView.reloadData()
            }
        }
    }
    
    func callApiForGapsInCareList(){
        ApiCallManager.sharedInstance.fetchDataFromRemote(params: [:], methodType: .get, apiName: "getGapsInCare") { (response, error) in
            print(JSON(response as Any))
            if response != nil {
                let responseData = JSON(response as Any)
                Loader.dismiss()
                for obj in responseData.rawValue as! Array<Dictionary<String, Any>?>  {
                    self.datasource_gapsInCare.append(self.gapsInCareResult.getGapsInCareDataFrom(dataDict: (obj )!))
                }
                self.healthProfiler_tableView.reloadData()
            }
        }
    }
}


//MARK: Public methods
extension HealthProfileViewController {
    
}


extension HealthProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 105
        case 1...2:
            return 70
        case 3:
            return 105
        case 4:
            return 120
        default:
            break
        }
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
            
            profilerCell.cellType = 0
            profilerCell.registerCell()
            profilerCell.title_label.text = "Gaps In Care"
            profilerCell.datasource_gapsInCare = datasource_gapsInCare
            return profilerCell
            
        case 1...2:
            let allergyCell = tableView.dequeueReusableCell(withIdentifier: AllergyTableViewCell.reuseableId(), for: indexPath) as! AllergyTableViewCell
            allergyCell.registerCell()
            allergyCell.datasource_allergy = datasource_allergy
            allergyCell.datasource_condition = datasource_conditions
            allergyCell.title_label.text = indexPath.row == 1 ? "Allergies" : "Conditions"
            allergyCell.cellType = indexPath.row == 1 ? 0 : 1
            return allergyCell
            
        case 3...4:
            let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
            profilerCell.registerCell()
            profilerCell.datasource_medication = datasource_medication
            profilerCell.datasource_careteam = datasource_careteam
            profilerCell.title_label.text = indexPath.row == 3 ? "Medications" : "My Care Team"
            profilerCell.cellType = indexPath.row == 3 ? 1 : 2
            
            return profilerCell
            
        default: break
        }
        
        return UITableViewCell()
    }
}
