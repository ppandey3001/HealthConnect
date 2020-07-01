//
//  HPTableViewCell.swift
//  HealthProfiler
//

import Foundation
import UIKit

class HPTableViewCell: UITableViewCell, ReuseIdentifiable {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension UITableViewCell {
    //MARK: - Register custom collectionView cell -
    func registerCollectionCell(_ collectionView: UICollectionView, cellClass: HPCollectionViewCell.Type) {
        
        let cellID = cellClass.reuseableId()
        collectionView.register(cellClass, forCellWithReuseIdentifier: cellID)
        collectionView.register(cellClass.nib(), forCellWithReuseIdentifier: cellID)
    }
    
    //MARK: - Register custom tableView cell -
    func registerTableCell(_ tableView: UITableView, cellClass: HPTableViewCell.Type) {
        
        let cellID = cellClass.reuseableId()
        tableView.register(cellClass, forCellReuseIdentifier: cellID)
        tableView.register(cellClass.nib(), forCellReuseIdentifier: cellID)
    }
}

