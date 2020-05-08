//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit
//import SwiftyJSON


class HomeViewController: HPViewController {
    
    @IBOutlet private var temp_label : UILabel!
    @IBOutlet private var heartRate_label : UILabel!
    @IBOutlet private var bp_label : UILabel!
    @IBOutlet private var bmi_label : UILabel!
    @IBOutlet private var height_label : UILabel!
    @IBOutlet private var weight_label : UILabel!
    
    @IBOutlet private var recent_tableView : UITableView!
    
    var dataSource_vital = HPVitalsItem([:])
    var dataSource_recentVisit = [HPRecentVisitItem]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
        callApi()
        addDrawerButton()
        addProfileButton
    }
}

//MARK: Private methods
private extension HomeViewController {
    
    private func setupController() {
        
        temp_label.text = dataSource_vital.bodytemprature
        heartRate_label.text = (dataSource_vital.heartrate ?? "") + " BPM"
        bp_label.text = dataSource_vital.bloodpressure
        bmi_label.text = dataSource_vital.bmi
        height_label.text = dataSource_vital.height
        weight_label.text = dataSource_vital.weight
        
        registerTableCell(recent_tableView, cellClass: REcentVisitTableCell.self)
        
        recent_tableView.delegate = self
        recent_tableView.dataSource = self
        recent_tableView.reloadData()
    }
    
    private func callApi() {
        
        callApiForVitalsList()
        callApiForRecentVisitList()
    }
    
    private func callApiForVitalsList() {
        
        Loader.show()
        let params = [
            "id" : "24",
        ]
        ApiCallManager.sharedInstance.fetchDataFromRemote(params: params, methodType: .get, apiName: "Vitals?") { (response, error) in
            print(JSON(response as Any))
            if response != nil {
                let responseData = JSON(response as Any)
                
                if let obj = responseData.rawValue as? Array<Dictionary<String, Any>>,
                    let vitals = obj.first {
                    self.dataSource_vital = HPVitalsItem(vitals)
                }
                self.setupController()
            }
        }
    }
    
    private func callApiForRecentVisitList() {
        
        let params = [
            "id" : "24",
        ]
        ApiCallManager.sharedInstance.fetchDataFromRemote(params: params, methodType: .get, apiName: "RecentVisits?") { (response, error) in
            print(JSON(response as Any))
            if response != nil {
                let responseData = JSON(response as Any)
                Loader.dismiss()
                print("getting response", responseData)
                
                if let dataList = responseData.rawValue as? Array<Dictionary<String, Any>> {
                    for obj in dataList  {
                        self.dataSource_recentVisit.append(HPRecentVisitItem(obj))
                    }
                }
                self.setupController()
            }
        }
    }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 194
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let visitsCell = tableView.dequeueReusableCell(withIdentifier: REcentVisitTableCell.reuseableId(), for: indexPath) as! REcentVisitTableCell
        visitsCell.registerCell()
        visitsCell.dataSource_recentVisit = dataSource_recentVisit
        return visitsCell
    }
    
}
