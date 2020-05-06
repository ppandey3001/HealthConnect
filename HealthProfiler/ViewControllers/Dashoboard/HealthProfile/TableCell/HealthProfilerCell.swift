//
//  HealthProfilerCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HealthProfilerCell: HPTableViewCell {
    
    @IBOutlet var section_collectionView : UICollectionView!
    @IBOutlet var title_label : UILabel!
    
    var cellType : Int = 0
    
    var datasource_gapsInCare = [HPGapsInCareItem]()
    var datasource_medication = [HPMedicationItem]()
    var datasource_careteam = [HPCareTeamItem]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        datasource_gapsInCare.removeAll()
        datasource_gapsInCare.append(HPGapsInCareItem(.appointment))
        datasource_gapsInCare.append(HPGapsInCareItem(.fluShot))
        datasource_gapsInCare.append(HPGapsInCareItem(.diabeties))
        datasource_gapsInCare.append(HPGapsInCareItem(.amaryl))
        datasource_gapsInCare.append(HPGapsInCareItem(.duetact))
        
        datasource_medication.removeAll()
        datasource_medication.append(HPMedicationItem(.amoxicillin))
        datasource_medication.append(HPMedicationItem(.cephalexin))
        
        datasource_careteam.removeAll()
        datasource_careteam.append(HPCareTeamItem(.william))
        datasource_careteam.append(HPCareTeamItem(.mindy))
        datasource_careteam.append(HPCareTeamItem(.veena))
        datasource_careteam.append(HPCareTeamItem(.sharon))
        datasource_careteam.append(HPCareTeamItem(.rodney))
        
    }
    
    func registerCell(){
        registerCollectionCell(section_collectionView, cellClass: GapsInCareCollectionCell.self)
        registerCollectionCell(section_collectionView, cellClass: MedicationCollectionCell.self)
        registerCollectionCell(section_collectionView, cellClass: CareTeamCollectionCell.self)
        
        if (cellType != 2){
            section_collectionView.backgroundColor = .clear
        }
        section_collectionView.alwaysBounceHorizontal = true
        section_collectionView.delegate = self
        section_collectionView.dataSource = self
        section_collectionView.reloadData()
    }
    
}

extension HealthProfilerCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case 0:
            return datasource_gapsInCare.count
        case 1:
            return datasource_medication.count
        case 2:
            return datasource_careteam.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case 0:
            return CGSize(width: 120, height: 60)
        case 1:
            return CGSize(width: 180, height: 80)
        case 2:
            return CGSize(width: 110, height: 90)
        default:
            return CGSize(width: 110, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cellType {
        case 0:
            let gapsCell = collectionView.dequeueReusableCell(withReuseIdentifier: GapsInCareCollectionCell.reuseableId(), for: indexPath) as! GapsInCareCollectionCell
            gapsCell.configureGapsInCareCell(item: datasource_gapsInCare[indexPath.row])
            
            return gapsCell
        case 1:
            let medicationCell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicationCollectionCell.reuseableId(), for: indexPath) as! MedicationCollectionCell
            medicationCell.configureMedicationCell(item: datasource_medication[indexPath.row])
            
            return medicationCell
        case 2:
            let careCell = collectionView.dequeueReusableCell(withReuseIdentifier: CareTeamCollectionCell.reuseableId(), for: indexPath) as! CareTeamCollectionCell
            careCell.configureCareCell(item: datasource_careteam[indexPath.row])
            
            return careCell
        default:
            break
        }
        return UICollectionViewCell()
        
    }
    
}