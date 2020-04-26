//
//  MenuTableCell.swift
//  HealthProfiler
//
//  Created by Krishna Kant Kaira on 26/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class MenuTableCell: HPTableViewCell {

    @IBOutlet var label_title: UILabel!
    
    func configureMenuCell(item: HPMenuItem) {
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        label_title.text = item.type.title
    }
    
    class func cellHeight() -> CGFloat {
        return 50.0
    }
}
