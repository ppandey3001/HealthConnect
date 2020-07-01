//
//  ManageConnectionViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 30/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class ManageConnectionViewCell: HPCollectionViewCell {
    
    @IBOutlet var icon_imageview: UIImageView!
    @IBOutlet var title_label: UILabel!
    @IBOutlet var connectedStatus_imageView: UIImageView!
    @IBOutlet var coloredbg_view: UIView!
        
    //configure cell for manage connection items
    func configureConnectionCell(item: HPConnectionItem, index: Int) {
        
        let attributes = item.type.attributes()
        icon_imageview.image = UIImage(named: attributes.icon)
        title_label.text = attributes.title
//        coloredbg_view.backgroundColor = attributes.bgColor

        if index == 0 || index == 1 {
            
            let insurerStatus = (HealthProfiler.shared.loggedInUser?.isInsurerConnected ?? false)
            let providerStatus = (HealthProfiler.shared.loggedInUser?.isProviderConnected ?? false)
            
            if index == 0 {
                
                connectedStatus_imageView.isHidden =  insurerStatus ? false : true
                
            } else if index == 1 {
                
                connectedStatus_imageView.isHidden =  providerStatus ? false : true
            }
        } else {

            connectedStatus_imageView.isHidden = true
        }
    }
}
