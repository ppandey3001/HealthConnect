//
//  HumanaTableViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 10/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HumanaTableViewCell: HPTableViewCell {
    
    @IBOutlet var label_title: UILabel!
    @IBOutlet var input_textField : UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        input_textField.layer.borderColor = UIColor.lightGray.cgColor
    }

    
}
extension HumanaTableViewCell{
     func configureHumanaCell(item: HPHumanaItem, index: Int) {
        
        input_textField.layer.borderColor = UIColor.lightGray.cgColor
        input_textField.layer.borderWidth = 1.0

        input_textField.addDoneButtonOnKeyboard()
        input_textField.tag = index + 1
        
        input_textField.text = item.value
        let attributes = item.type.attributes()
        label_title.text = attributes.title
        input_textField.placeholder = attributes.placeholder
    }
}
