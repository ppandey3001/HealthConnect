//
//  CernerConditionTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class CernerConditionTableCell: HPTableViewCell {
        
        @IBOutlet var condition_collectionView : UICollectionView!
        @IBOutlet var title_label : UILabel!
        
    var datasource_condition = [HPCernerConditionItem]()
        
        func registerCell() {
            
            datasource_condition = [HPCernerConditionItem(.atherosclerosis), HPCernerConditionItem(.chronic)]
            registerCollectionCell(condition_collectionView, cellClass: CernerConditionCollectionCell.self)
            
            condition_collectionView.alwaysBounceHorizontal = true
            condition_collectionView.delegate = self
            condition_collectionView.dataSource = self
            condition_collectionView.reloadData()
        }
    }


    extension CernerConditionTableCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

                return datasource_condition.count

        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 280, height: 240)
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cernerCell = collectionView.dequeueReusableCell(withReuseIdentifier: CernerConditionCollectionCell.reuseableId(), for: indexPath) as! CernerConditionCollectionCell
                cernerCell.configureCell()
                cernerCell.configureCernerConditionCell(item: datasource_condition[indexPath.row])
                return cernerCell
        }
        
    }
