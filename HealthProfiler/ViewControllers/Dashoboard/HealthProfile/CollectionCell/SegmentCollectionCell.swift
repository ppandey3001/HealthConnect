//
//  SegmentCollectionCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 07/07/20.
//  Copyright © 2020 UHG. All rights reserved.
//

import UIKit

class SegmentCollectionCell: HPCollectionViewCell {
    
    @IBOutlet var icon_imageView : UIImageView!
    @IBOutlet var title_label : UILabel!
    @IBOutlet var bg_view : UIView!
    
    var selectedSegment = Int()

}
extension SegmentCollectionCell {
    
    func configureSegments(item : HPSegmentItem, index: Int) {
        
        let attributes = item.type.attributes()
        icon_imageView.image = UIImage(named: attributes.icon)
        title_label.text = attributes.title
        if index == selectedSegment {
            bg_view.backgroundColor = UIColor.colorFromRGB(229, 229, 229)
        }else {
            bg_view.backgroundColor = UIColor.colorFromRGB(250, 250, 250)
        }
        
    }
    

}
