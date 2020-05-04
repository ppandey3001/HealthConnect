//
//  LoginViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 24/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class LoginViewCell: HPTableViewCell {
    
    @IBOutlet var view_container : UIView!
    @IBOutlet var imageView_icon : UIImageView!
    @IBOutlet var textField_input : UITextField!
    @IBOutlet var button_showSecureEntry : UIButton!
    @IBOutlet var imageView_showpassowrd : UIImageView!
    @IBOutlet var view_accessory: UIView!
    
    private func configureCell(with item: HPProfileItem, index: Int) {
        
        textField_input.addDoneButtonOnKeyboard()
        textField_input.tag = index + 1
        
        textField_input.text = item.value
        button_showSecureEntry.setImage(UIImage(named: ""), for: .normal)
        let attributes = item.type.attributes()
        textField_input.isSecureTextEntry = attributes.isSecure
        textField_input.placeholder = attributes.placeholder
        imageView_icon.image = UIImage(named: attributes.icon)
        view_accessory.isHidden = true
    }
}

//MARK: public methods
extension LoginViewCell {
    
    //configure cell for login items
    func configureLoginCell(item: HPProfileItem, index: Int) {
        
        configureCell(with: item, index: index)
    }
    
    //configure cell for registration items
    func configureRegisterCell(item: HPProfileItem, index: Int) {
        
        configureCell(with: item, index: index)
        
        view_container.layer.borderColor = UIColor.lightGray.cgColor
        view_container.layer.borderWidth = 1.0
        
        let attributes = item.type.attributes()
        view_accessory.isHidden = !attributes.isSecure
    }
    
    //configure cell for health insurance items
    func configureHealthInsuranceCell(item: HPHealthInsuranceItem, index: Int) {
        
        textField_input.addDoneButtonOnKeyboard()
        textField_input.tag = index + 1
        
        textField_input.text = item.value
        
        let attributes = item.type.attributes()
        textField_input.isSecureTextEntry = attributes.isSecure
        textField_input.placeholder = attributes.placeholder
        imageView_icon.image = UIImage(named: attributes.icon)
        view_accessory.isHidden = index == 0 ? false : true
        imageView_showpassowrd.isHidden = true
        view_container.layer.borderColor = UIColor.lightGray.cgColor
        view_container.layer.borderWidth = 1.0
    }
}
