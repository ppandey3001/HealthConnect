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
    
    @IBOutlet private var segment_collection : UICollectionView!
        
    var datasource_medicationList = [HPMedicationItem]()
    var datasource_gapsInCareList = [HPGapsInCareItem]()
    var datasource_allergyList = [HPAllergiesItem]()
    var datasource_condition = [HPHistoryConditionItem]()
    var datasource_segment = [HPSegmentItem]()
    
    var datasource_StaticallergyList = [HPAllergyItem]()
    var datasource_StaticmedicationList = [HPMedicationsItem]()
    var datasource_StaticgapsInCareList = [HPGapsItem]()

    
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
        registerCollectionCell(segment_collection, cellClass: SegmentCollectionCell.self)

        datasource_segment = [HPSegmentItem(.conditions), HPSegmentItem(.allergies), HPSegmentItem(.medications), HPSegmentItem(.gapsInCare)]

        datasource_condition = [HPHistoryConditionItem(.diabeties),HPHistoryConditionItem(.chronic), HPHistoryConditionItem(.hypertension)]
        
        datasource_StaticallergyList = [HPAllergyItem(.glucophage), HPAllergyItem(.heparins), HPAllergyItem(.inhibitors), HPAllergyItem(.iodinated), HPAllergyItem(.keflex), HPAllergyItem(.lisinopril), HPAllergyItem(.morphine), HPAllergyItem(.nsaid)]
        datasource_StaticmedicationList = [HPMedicationsItem(.amiodrane)]
        datasource_StaticgapsInCareList = [HPGapsItem(.diabetes), HPGapsItem(.colorectal), HPGapsItem(.fraility)]
        
        history_tableView.delegate = self
        history_tableView.dataSource = self
        segment_collection.delegate = self
        segment_collection.dataSource = self
        
        self.navigationItem.title = "History"
        
    }

}

extension HIstoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selectedSegmentType {
        case 0:
            return datasource_condition.count
        case 1:
            return datasource_allergyList.count > 0 ? datasource_allergyList.count : datasource_StaticallergyList.count
        case 2:
            return datasource_medicationList.count > 0 ? datasource_medicationList.count : datasource_StaticmedicationList.count
        case 3:
            return datasource_gapsInCareList.count > 0 ? datasource_gapsInCareList.count : datasource_StaticgapsInCareList.count
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
            
            if datasource_allergyList.count > 0 {
                
            allergyCell.configureAllergyCell(item: datasource_allergyList[indexPath.row])
            }else {
                
                allergyCell.configureStaticAllergyCell(item: datasource_StaticallergyList[indexPath.row])
            }
            
            return allergyCell
        case 2:
            let profilerCell = tableView.dequeueReusableCell(withIdentifier: HistoryMedicationTableCell.reuseableId(), for: indexPath) as! HistoryMedicationTableCell
            
            if datasource_medicationList.count > 0 {
                
                profilerCell.configureMedicationCell(item: datasource_medicationList[indexPath.row])
            }else {
                
                profilerCell.configureStaticMedicationCell(item: datasource_StaticmedicationList[indexPath.row])
            }
            
            return profilerCell
            
        case 3:
            
            let profilerCell = tableView.dequeueReusableCell(withIdentifier: HealthProfilerCell.reuseableId(), for: indexPath) as! HealthProfilerCell
           
            if datasource_gapsInCareList.count > 0 {
                
                profilerCell.configureGapsInCareCell(item: datasource_gapsInCareList[indexPath.row])
            }else {
                
                profilerCell.configureStaticGapsInCareCell(item: datasource_StaticgapsInCareList[indexPath.row])
            }
            
            return profilerCell
            
        default:
            break
        }
        
        return UITableViewCell()
        
    }
    
    
}

extension HIstoryViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
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
        history_tableView.reloadData()
        segment_collection.reloadData()
    }
    
    
}
