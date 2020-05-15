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
    @IBOutlet var status_label: UILabel!
    @IBOutlet var coloredbg_view: UIView!
        
    //configure cell for manage connection items
    func configureConnectionCell(item: HPConnectionItem, index: Int) {
        
        let attributes = item.type.attributes()
        icon_imageview.image = UIImage(named: attributes.icon)
        title_label.text = attributes.title
        if index == 0 || index == 1 {
            
            let insurerStatus = (HealthProfiler.shared.loggedInUser?.isInsurerConnected ?? false)
            let providerStatus = (HealthProfiler.shared.loggedInUser?.isProviderConnected ?? false)
            
            if index == 0 {
                
                status_label.textColor = insurerStatus == true ? UIColor.colorFromRGB(89, 189, 20) : UIColor.lightGray
                coloredbg_view.backgroundColor = insurerStatus == true ? UIColor.colorFromRGB(89, 189, 20) : UIColor.colorFromRGB(201, 201, 201)
                status_label.text =  insurerStatus ? "Connected" : "No connections"
            } else if index == 1 {
                
                status_label.textColor = providerStatus == true ? UIColor.colorFromRGB(89, 189, 20) : UIColor.lightGray
                coloredbg_view.backgroundColor = providerStatus == true ? UIColor.colorFromRGB(89, 189, 20) : UIColor.colorFromRGB(201, 201, 201)
                status_label.text =  providerStatus ? "Connected" : "No connections"
            }
        } else {
            status_label.textColor = UIColor.lightGray
            coloredbg_view.backgroundColor = UIColor.colorFromRGB(201, 201, 201)
            status_label.text =  "No connections"
        }
    }
}
