//
//  CoverageViewController.swift
//  HealthProfiler
//

import UIKit

class CoverageViewController: HPViewController {
    
    @IBOutlet private var coverage_tableView : UITableView!
    
    private var dataSource_coverage = [HPCoverageClaimItem]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
}

//MARK: Private methods
private extension CoverageViewController {
    
    private func setupController() {
        
        dataSource_coverage.removeAll()
        dataSource_coverage = [HPCoverageClaimItem(.drPOe), HPCoverageClaimItem(.drSmith)]
        
        registerTableCell(coverage_tableView, cellClass: CoverageTableCell.self)
        registerTableCell(coverage_tableView, cellClass: CoverageClaimHeaderCell.self)
        registerTableCell(coverage_tableView, cellClass: RecentCliamsListCell.self)
        
        coverage_tableView.delegate = self
        coverage_tableView.dataSource = self
        coverage_tableView.reloadData()
        
    }
}


//MARK: Public methods
extension CoverageViewController {
    
}

extension CoverageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_coverage.count + 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 170
        case 1:
            return 90
        case 2:
            return 55
        default:
            break
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let claimListCell = tableView.dequeueReusableCell(withIdentifier: RecentCliamsListCell.reuseableId()) as! RecentCliamsListCell
        
        switch indexPath.row {
        case 0:
            let coverageCell = tableView.dequeueReusableCell(withIdentifier: CoverageTableCell.reuseableId(), for: indexPath) as! CoverageTableCell
            return coverageCell
            
        case 1:
            let claimHeaderCell = tableView.dequeueReusableCell(withIdentifier: CoverageClaimHeaderCell.reuseableId(), for: indexPath) as! CoverageClaimHeaderCell
            return claimHeaderCell
            
        case 2...dataSource_coverage.count + 2:
            print(indexPath.row, dataSource_coverage[indexPath.row - 2])
            claimListCell.configureRecentClaimCell(item: dataSource_coverage[indexPath.row - 2], index: indexPath.row - 2 )
            return claimListCell
            
        default:
            break
        }
        
        return claimListCell
    }
}
