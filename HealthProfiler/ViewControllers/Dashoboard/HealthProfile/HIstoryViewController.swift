//
//  HIstoryViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/07/20.
//  Copyright © 2020 UHG. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class HIstoryViewController: HPViewController {
    
    @IBOutlet private var history_tableView: UITableView!
    
    @IBOutlet private var segmentedControl: ScrollableSegmentedControl!
    
    var datasource_medicationList = [HPMedicationItem]()
    var datasource_gapsInCareList = [HPGapsInCareItem]()
    var datasource_allergyList = [HPAllergiesItem]()
    var datasource_condition = [HPHistoryConditionItem]()

    
    var selectedSegmentType : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }

}


//MARK: Private methods
private extension HIstoryViewController {
    
    private func setupController() {
        
        registerTableCell(history_tableView, cellClass: HistoryConditionTableCell.self)
        registerTableCell(history_tableView, cellClass: HealthProfilerCell.self)
        registerTableCell(history_tableView, cellClass: AllergyTableViewCell.self)
        registerTableCell(history_tableView, cellClass: HistoryMedicationTableCell.self)

        datasource_condition = [HPHistoryConditionItem(.diabeties),HPHistoryConditionItem(.chronic), HPHistoryConditionItem(.hypertension)]

        history_tableView.delegate = self
        history_tableView.dataSource = self
        
        self.navigationItem.title = "History"
        
        setUpSegment()
    }
    
    private func setUpSegment() {
        

        segmentedControl.segmentStyle = .imageOnTop
        segmentedControl.insertSegment(withTitle: "Conditions", image:UIImage(named: "conditions"), at: 0)
        segmentedControl.insertSegment(withTitle: "Allergies", image: UIImage(named: "allergy"), at: 1)
        segmentedControl.insertSegment(withTitle: "Medications", image: UIImage(named: "medication"), at: 2)
        segmentedControl.insertSegment(withTitle: "Gaps In Care", image: UIImage(named: "gapsincare"), at: 3)


        segmentedControl.underlineSelected = true

        segmentedControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)

        // change some colors
        segmentedControl.segmentContentColor = UIColor.darkGray
        segmentedControl.selectedSegmentContentColor = UIColor.darkGray
        segmentedControl.backgroundColor = UIColor.clear
        segmentedControl.selectedSegmentIndex = 0

        // Turn off all segments been fixed/equal width.
        // The width of each segment would be based on the text length and font size.
        segmentedControl.fixedSegmentWidth = true
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        selectedSegmentType = sender.selectedSegmentIndex
        history_tableView.reloadData()

    }
}

extension HIstoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selectedSegmentType {
        case 0:
            return datasource_condition.count
        case 1:
            return 6
        case 2:
            return datasource_medicationList.count
        case 3:
            return datasource_gapsInCareList.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectedSegmentType {
        case 0:
            return 92
        case 1:
            return 92
        case 2:
            return 92
        case 3:
            return 80
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            switch selectedSegmentType {
            case 0:
                
                let conditionCell = tableView.dequeueReusableCell(withIdentifier: HistoryConditionTableCell.reuseableId(), for: indexPath) as! HistoryConditionTableCell
                conditionCell.configureConditionCell(item: datasource_condition[indexPath.row])
                
                return conditionCell
                
            case 1:
                     let allergyCell = tableView.dequeueReusableCell(withIdentifier: HistoryConditionTableCell.reuseableId(), for: indexPath) as! HistoryConditionTableCell
                     
                     allergyCell.configureAllergyCell(item: datasource_allergyList[indexPath.row])
                     
                     return allergyCell
            case 2:
                let profilerCell = tableView.dequeueReusableCell(withIdentifier: HistoryMedicationTableCell.reuseableId(), for: indexPath) as! HistoryMedicationTableCell
                
                profilerCell.configureMedicationCell(item: datasource_medicationList[indexPath.row])
                
                return profilerCell
                
            case 3:
              
                let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
                
                profilerCell.configureGapsInCareCell(item: datasource_gapsInCareList[indexPath.row])
                
                return profilerCell
                
            default:
                break
            }
        
        return UITableViewCell()

    }
    
    
}
