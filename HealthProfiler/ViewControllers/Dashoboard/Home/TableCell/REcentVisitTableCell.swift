//
//  REcentVisitTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 07/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class REcentVisitTableCell: HPTableViewCell {
    
    @IBOutlet var collection : UICollectionView!
    var dataSource_recentVisit = [HPRecentVisitItem]()
    
    
    func registerCell(){
        registerCollectionCell(collection, cellClass: RecentVisitCollectionCell.self)
        collection.dataSource = self
        collection.delegate = self
        collection.reloadData()
    }
    
}

extension REcentVisitTableCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource_recentVisit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let visitCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentVisitCollectionCell.reuseableId(), for: indexPath) as! RecentVisitCollectionCell
        
        visitCell.line_label.isHidden = indexPath.row == dataSource_recentVisit.count - 1 ? true : false
        visitCell.configureRecentVisitCell(item: dataSource_recentVisit[indexPath.row])
        
        return visitCell
        
    }
    
}
