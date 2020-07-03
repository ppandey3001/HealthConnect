//
//  CoverageViewController.swift
//  HealthProfiler
//

import UIKit
import DataCache

class CoverageViewController: HPViewController {
    
    @IBOutlet private var coverage_tableView : UITableView!
    @IBOutlet private var memberID_Label : UILabel!
    @IBOutlet private var status_label : UILabel!
    @IBOutlet private var claimsTitle_label : UILabel!
    @IBOutlet private var refreshMedicare_Button : UIButton!
    @IBOutlet private var lastUpdateTitle_Label : UILabel!
    
    private var dataSource_eobList = [HPEobItem]()


    private var dataSource_coverage = [HPCoverageClaimItem]()
    private let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let user = user,
        user.blueButtonConnected && dataSource_eobList.count <= 0 {
            
        callApiForEobList(token: HealthProfiler.shared.blueButtonToken ?? "")
            
        }
        updateUI()
    }
    
    @IBAction func refreshButtonAction(_ sender : UIButton) {
        
//        HealthProfiler.shared.loggedInUser?.blueButtonConnected = false
        DataCache.instance.write(string: "", forKey: "BlueButtonConnectionTime")
        HealthProfiler.authClient.authorize(controller: self) { [weak self] (token, error) in
            
            if token != nil {
                
                TabBarCoordinator.shared.tabBarStatus(isUserConnected:true)

                let date = HPDateFormatter.shared.getString(from: Date(), format: .date)
                DataCache.instance.write(string: date, forKey: "BlueButtonConnectionTime")
                DataCache.instance.write(string: "true", forKey: "BlueButtonConnectedWilma")
                self?.callApiForEobList(token: token ?? "")

                self?.coverage_tableView.reloadData()

            } else {
                debugPrint(error.debugDescription)
            }
        }
    }
}


//MARK: Private methods
private extension CoverageViewController {
    
    private func setupController() {
        
        registerTableCell(coverage_tableView, cellClass: CoverageTableCell.self)
        registerTableCell(coverage_tableView, cellClass: CoverageClaimHeaderCell.self)
        registerTableCell(coverage_tableView, cellClass: RecentCliamsListCell.self)
        
        status_label.layer.cornerRadius = 5.0
        status_label.layer.masksToBounds = true
        
        coverage_tableView.delegate = self
        coverage_tableView.dataSource = self
        coverage_tableView.reloadData()
        
    }
    
    private func updateUI() {
        
        dataSource_coverage.removeAll()
        
        if let user = user,
            user.blueButtonConnected {
            lastUpdateTitle_Label.text = "Last updated : \(DataCache.instance.readString(forKey: "BlueButtonConnectionTime")!)"
            
            dataSource_coverage = [HPCoverageClaimItem(.drWilliam), HPCoverageClaimItem(.drTammy), HPCoverageClaimItem(.drGayle), HPCoverageClaimItem(.drVeena), HPCoverageClaimItem(.drJones), HPCoverageClaimItem(.drNorma), HPCoverageClaimItem(.drJohnson), HPCoverageClaimItem(.drMinnnie), HPCoverageClaimItem(.drAllison), HPCoverageClaimItem(.drJohn)]
            
        } else {
            dataSource_coverage = []
            
        }

        memberID_Label.text = user?.memberID
        lastUpdateTitle_Label.isHidden = user?.blueButtonConnected ?? false ? false : true
        claimsTitle_label.isHidden = user?.blueButtonConnected ?? false ? false : true
        refreshMedicare_Button.isHidden = user?.blueButtonConnected ?? false ? false : true
        
        coverage_tableView.reloadData()
    }
        
        private func callApiForEobList(token : String) {
            
            Loader.show()
            
            HealthProfiler.networkManager.getEobData(token: token) { [weak self] (eobList, error) in
                
                if let strongSelf = self {
                    Loader.dismiss()
                    HealthProfiler.shared.loggedInUser?.blueButtonConnected = true
                    strongSelf.dataSource_eobList.removeAll()
                    if let eobList = eobList {
                        strongSelf.dataSource_eobList = eobList
                        self?.updateUI()
                    } else {
                        strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                    }
                }
            }
        }
    
}


//UITableViewDelegate, UITableViewDataSource
extension CoverageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_eobList.count > 0 ? dataSource_eobList.count - 1 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let claimListCell = tableView.dequeueReusableCell(withIdentifier: RecentCliamsListCell.reuseableId()) as! RecentCliamsListCell

            claimListCell.registerCell()
            claimListCell.configureRecentClaimCell(item: dataSource_eobList[indexPath.row])
            return claimListCell
    }
}
