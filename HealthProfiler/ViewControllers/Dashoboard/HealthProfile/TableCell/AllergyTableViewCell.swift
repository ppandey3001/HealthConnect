//
//  AllergyTableViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit
import Foundation


class AllergyTableViewCell: HPTableViewCell {
    
    @IBOutlet var section_collectionView : UICollectionView!
    @IBOutlet var title_label : UILabel!
    
    var cellType : Int = 0
    
    var datasource_allergy = [HPAllergiesItem]()
    var datasource_condition = [HPConditionItem]()
    
    func registerCell() {
        
        registerCollectionCell(section_collectionView, cellClass: GapsInCareCollectionCell.self)
        
        section_collectionView.alwaysBounceHorizontal = true
        section_collectionView.delegate = self
        section_collectionView.dataSource = self
        section_collectionView.reloadData()
    }
}


extension AllergyTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch cellType {
            
        case 0:
            return datasource_allergy.count
            
        case 1:
            return datasource_condition.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let gapsCell = collectionView.dequeueReusableCell(withReuseIdentifier: GapsInCareCollectionCell.reuseableId(), for: indexPath) as! GapsInCareCollectionCell
        gapsCell.icon_imageView.isHidden = true
        gapsCell.title_label.font = gapsCell.title_label.font.withSize(12)
        
        switch cellType {
            
        case 0:
            gapsCell.configureAllergyCell(item: datasource_allergy[indexPath.row])
            return gapsCell
            
        case 1:
            gapsCell.configureConditionCareCell(item: datasource_condition[indexPath.row])
            return gapsCell
            
        default:
            return UICollectionViewCell()
        }
    }
    
}
