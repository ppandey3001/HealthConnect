//
//  ProviderConnectedCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class ProviderConnectedCell: HPTableViewCell {
    
    @IBOutlet var title_label : UILabel!
    @IBOutlet var icon_imageView : UIImageView!
    @IBOutlet var activeStatus_Button : UIButton!
    @IBOutlet var refresh_Button : UIButton!
    @IBOutlet var connect_Button : UIButton!
    
}

//MARK: public methods
extension ProviderConnectedCell {
    
    //configure cell for Provider items
    func configureProviderCell(item: HPConnectedProviderItem, index: Int) {
        
        let attributes = item.type.attributes()
        icon_imageView.image = UIImage(named: attributes.icon)
        title_label.text = attributes.title
    }
    
}
