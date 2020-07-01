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
    @IBOutlet var poweredBy : UIImageView!
    @IBOutlet var icon_imageView : UIImageView!
//    @IBOutlet var activeStatus_Button : UISwitch!
    @IBOutlet var refresh_Button : UIButton!
    @IBOutlet var connect_Button : UISwitch!
    @IBOutlet var suggestion_View : UIView!
    @IBOutlet var suggestion_Label : UILabel!
    @IBOutlet var bg_view : UIView!
    
    func registerCell() {
        
        bg_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        bg_view.layer.shadowOpacity = 1
        bg_view.layer.cornerRadius = 10.0
        bg_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        bg_view.layer.shadowRadius = 1
    }

}

//MARK: public methods
extension ProviderConnectedCell {
    
    //configure cell for Provider items
    func configureProviderCell(item: HPConnectedProviderItem, index: Int, user: Bool) {
        
        let attributes = item.type.attributes()
        icon_imageView.image = UIImage(named: attributes.icon)
        poweredBy.image = UIImage(named: attributes.poweredBy)
        title_label.text = attributes.title
        
        if user {
            
//            activeStatus_Button.isSelected = HealthProfiler.shared.loggedInUser?.isProviderConnected ?? false
            connect_Button.isSelected = item.isConnected ?? false
            suggestion_View.isHidden =  (HealthProfiler.shared.loggedInUser?.isProviderConnected ?? false)
            suggestion_Label.text = "You have recently visited \(attributes.title), Do you want to connect with them ?"
            
        } else {
//            activeStatus_Button.isSelected = item.type == .southwest ? true : (HealthProfiler.shared.loggedInUser?.cernerConnected ?? false)
            connect_Button.isSelected = item.type == .southwest ? true : (HealthProfiler.shared.loggedInUser?.cernerConnected ?? false)
            suggestion_View.isHidden = item.type == .southwest ? true : (HealthProfiler.shared.loggedInUser?.cernerConnected ?? false)
            suggestion_Label.text = "You have recently visited \(attributes.title), Do you want to connect with them ?"

        }
    }
}
