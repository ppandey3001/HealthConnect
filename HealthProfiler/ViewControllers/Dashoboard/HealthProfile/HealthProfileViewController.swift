//
//  HealthProfileViewController.swift
//  HealthProfiler
//

import UIKit

class HealthProfileViewController: HPViewController {
    
    @IBOutlet private var healthProfiler_tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
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
            return profilerCell
            
        case 1...2:
            let allergyCell = tableView.dequeueReusableCell(withIdentifier: AllergyTableViewCell.reuseableId(), for: indexPath) as! AllergyTableViewCell
            allergyCell.registerCell()
            allergyCell.title_label.text = indexPath.row == 1 ? "Allergies" : "Conditions"
            allergyCell.cellType = indexPath.row == 1 ? 0 : 1
            return allergyCell
            
        case 3...4:
            let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
            
            profilerCell.registerCell()
            profilerCell.title_label.text = indexPath.row == 3 ? "Medications" : "My Care Team"
            profilerCell.cellType = indexPath.row == 3 ? 1 : 2
            
            
            return profilerCell
            
        default:
            break
        }
        return UITableViewCell()
    }
    
}

