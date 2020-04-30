//
//  ManageConnectionViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 30/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class ManageConnectionViewCell: UICollectionViewCell {
    
    @IBOutlet var icon_imageview: UIImageView!
    @IBOutlet var title_label: UILabel!
    @IBOutlet var status_label: UILabel!
    
    //configure cell for manage connection items
    func configureConnectionCell(item: HPConnectionItem) {
        
        let attributes = item.type.attributes()
        icon_imageview.image = UIImage(named: attributes.icon)
        title_label.text = attributes.labelTitle
        status_label.text = attributes.status == true ? "connected" : "No connections"
    }
}
