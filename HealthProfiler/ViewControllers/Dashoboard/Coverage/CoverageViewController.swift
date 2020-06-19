//
//  CoverageViewController.swift
//  HealthProfiler
//

import UIKit
import DataCache

class CoverageViewController: HPViewController {
    
    @IBOutlet private var coverage_tableView : UITableView!
    @IBOutlet private var updated_Label : UILabel!
    @IBOutlet private var memberID_Label : UILabel!
    @IBOutlet private var refreshIcon_button : UIButton!
    @IBOutlet private var mcValue_Label : UILabel!
    @IBOutlet private var mdValue_Label : UILabel!
    @IBOutlet private var smoking_Button : UIButton!
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
        
        coverage_tableView.delegate = self
        coverage_tableView.dataSource = self
        coverage_tableView.reloadData()
    }
    
    private func updateUI() {
        
        dataSource_coverage.removeAll()
        
        if let user = user,
            user.blueButtonConnected {
            updated_Label.text = DataCache.instance.readString(forKey: "BlueButtonConnectionTime")
            dataSource_coverage = [HPCoverageClaimItem(.drMinnnie), HPCoverageClaimItem(.drJones), HPCoverageClaimItem(.drAllison), HPCoverageClaimItem(.drNorma), HPCoverageClaimItem(.drJohn), HPCoverageClaimItem(.drTammy), HPCoverageClaimItem(.drWilliam), HPCoverageClaimItem(.drGayle), HPCoverageClaimItem(.drVeena), HPCoverageClaimItem(.drJohnson)]
        } else {
            dataSource_coverage = []
            
        }
        
        if user?.isFirstTimeUser ?? false {
            self.navigationItem.title = user?.isInsurerConnected ?? false ? "\(user?.name! ?? "")  |  \(user?.age! ?? "") Y  | \(user?.gender! ?? "")" : "\(user?.name! ?? "")"
        }
        refreshIcon_button.isHidden = user?.blueButtonConnected ?? false ? false : true
        memberID_Label.text = user?.memberID
        mcValue_Label.isHidden = user?.blueButtonConnected ?? false ? false : true
        mdValue_Label.isHidden = user?.blueButtonConnected ?? false ? false : true
        smoking_Button.isHidden = user?.blueButtonConnected ?? false ? false : true
        lastUpdateTitle_Label.isHidden = user?.blueButtonConnected ?? false ? false : true
        refreshMedicare_Button.isHidden = user?.blueButtonConnected ?? false ? false : true
        
        coverage_tableView.reloadData()
    }
        
        private func callApiForEobList(token : String) {
            
            Loader.show()
            
            HealthProfiler.networkManager.getEobData(token: token) { [weak self] (eobList, error) in
                
                if let strongSelf = self {
                    Loader.dismiss()
                    HealthProfiler.shared.loggedInUser?.blueButtonConnected = true
                    self?.updateUI()
                    strongSelf.dataSource_eobList.removeAll()
                    if let eobList = eobList {
                        strongSelf.dataSource_eobList = eobList
                        //                    strongSelf.recent_tableView.reloadData()
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
        return dataSource_coverage.count > 0 ? dataSource_coverage.count + 1 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {

        case 0:
            return 90
            
        case 1:
            return 72
            
        default: break
        }
        
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let claimListCell = tableView.dequeueReusableCell(withIdentifier: RecentCliamsListCell.reuseableId()) as! RecentCliamsListCell
        
        switch indexPath.row {

        case 0:
            let claimHeaderCell = tableView.dequeueReusableCell(withIdentifier: CoverageClaimHeaderCell.reuseableId(), for: indexPath) as! CoverageClaimHeaderCell
            return claimHeaderCell
            
        case 1...dataSource_coverage.count + 1:
            print(indexPath.row, dataSource_coverage[indexPath.row - 1])
            claimListCell.configureRecentClaimCell(item: dataSource_coverage[indexPath.row - 1], index: indexPath.row - 1 )
            return claimListCell
            
        default: break
        }
        
        return claimListCell
    }
}
