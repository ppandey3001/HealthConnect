//
//  MenuTableCell.swift
//  HealthProfiler
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
        return 35.0
    }
}
