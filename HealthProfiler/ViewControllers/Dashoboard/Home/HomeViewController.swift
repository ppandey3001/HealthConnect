//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit
import SwiftyJSON

class HomeViewController: HPViewController {
    
    @IBOutlet private var temp_label : UILabel!
    @IBOutlet private var heartRate_label : UILabel!
    @IBOutlet private var bp_label : UILabel!
    @IBOutlet private var bmi_label : UILabel!
    @IBOutlet private var height_label : UILabel!
    @IBOutlet private var weight_label : UILabel!
    @IBOutlet private var recent_tableView : UITableView!
    
    private var userVital: HPVitalsItem?
    private var dataSource_recentVisit = [HPRecentVisitItem]()
    private var user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
}

//MARK: Private methods
private extension HomeViewController {
    
    private func setupController() {
                
        registerTableCell(recent_tableView, cellClass: REcentVisitTableCell.self)
        
        recent_tableView.delegate = self
        recent_tableView.dataSource = self
        recent_tableView.reloadData()
        addProfileButton()
        
        //fetch data from server
        if let user = user,
            user.blueButtonConnected {
            
            callApiForVitalsList()
            callApiForRecentVisitList()
        }
    }
    
    private func userVitalReceived(vital: HPVitalsItem) {
        
        userVital = vital
        temp_label.text = userVital?.bodytemprature
        heartRate_label.text = (userVital?.heartrate ?? "N/A") + " BPM"
        bp_label.text = userVital?.bloodpressure
        bmi_label.text = userVital?.bmi
        height_label.text = userVital?.height
        weight_label.text = userVital?.weight
    }
}

//MARK: - API interaction -
extension HomeViewController {
    
    private func callApiForVitalsList() {
        
        Loader.show()
        
        HealthProfiler.networkManager.getVitalData(id: "24") { [weak self] (vitalItem, error) in
            
            if let strongSelf = self {
                
                if let vitalItem = vitalItem {
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
}


//MARK: - UITableViewDelegate, UITableViewDataSource -
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((dataSource_recentVisit.count > 0) ? 1 : 0)
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
