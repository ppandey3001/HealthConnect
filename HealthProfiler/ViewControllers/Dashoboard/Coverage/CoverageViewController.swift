//
//  CoverageViewController.swift
//  HealthProfiler
//

import UIKit
import DataCache

class CoverageViewController: HPViewController {
    
    @IBOutlet private var coverage_tableView : UITableView!
    @IBOutlet private var updated_Label : UILabel!

    private var dataSource_coverage = [HPCoverageClaimItem]()
    private let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        dataSource_coverage.removeAll()
        
        //fetch data from server
        if let user = user,
            user.blueButtonConnected {
            updated_Label.text = DataCache.instance.readString(forKey: "BlueButtonConnectionTime")
            dataSource_coverage = [HPCoverageClaimItem(.drMinnnie), HPCoverageClaimItem(.drJones), HPCoverageClaimItem(.drAllison), HPCoverageClaimItem(.drNorma), HPCoverageClaimItem(.drJohn), HPCoverageClaimItem(.drTammy), HPCoverageClaimItem(.drWilliam), HPCoverageClaimItem(.drGayle), HPCoverageClaimItem(.drVeena), HPCoverageClaimItem(.drJohnson)]
        } else {
            dataSource_coverage = []
            
        }
        
        coverage_tableView.reloadData()
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
}


//UITableViewDelegate, UITableViewDataSource
extension CoverageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_coverage.count + 1
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
