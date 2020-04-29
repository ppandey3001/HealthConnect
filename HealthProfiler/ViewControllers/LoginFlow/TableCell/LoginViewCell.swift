//
//  LoginViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 24/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class LoginViewCell: UITableViewCell {
    
    @IBOutlet var iconImage : UIImageView!
    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var showPasswordButton : UIButton!
    @IBOutlet var txtFieldBackgroundView : UIView!
    
    func configureRegisterCell(index : Int, item : LoginModal) {
        
        usernameTextField.tag = index + 1
        usernameTextField.addDoneButtonOnKeyboard()
        txtFieldBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        txtFieldBackgroundView.layer.borderWidth = 1.0
        showPasswordButton.tag = index + 1
        
        switch  index {
            
        case 0:
            usernameTextField.placeholder = "Name"
            usernameTextField.text = item.name ?? ""
            iconImage.image = UIImage(named: "name")
            usernameTextField.returnKeyType = .next
            
        case 1:
            usernameTextField.placeholder = "Email"
            usernameTextField.text = item.email ?? ""
            iconImage.image = UIImage(named: "email")
            usernameTextField.returnKeyType = .next
            
        case 2:
            usernameTextField.placeholder = "Password"
            usernameTextField.text = item.password ?? ""
            iconImage.image = UIImage(named: "password-icon")
            showPasswordButton.isHidden = false
            usernameTextField.isSecureTextEntry = true
            usernameTextField.returnKeyType = .next
            
        case 3:
            usernameTextField.placeholder = "Confirm Password"
            usernameTextField.text = item.confirmPassword ?? ""
            iconImage.image = UIImage(named: "password-icon")
            showPasswordButton.isHidden = false
            usernameTextField.isSecureTextEntry = true
            usernameTextField.returnKeyType = .done
            
        default: break
        }
    }
    
    func configureLoginCell(index : Int, item : LoginModal) {
        usernameTextField.tag = index + 1
        usernameTextField.addDoneButtonOnKeyboard()
        
        switch  index {
            
        case 0:
            usernameTextField.placeholder = "Username"
            usernameTextField.text = item.username ?? ""
            usernameTextField.returnKeyType = .next
            
        case 1:
            usernameTextField.placeholder = "Password"
            usernameTextField.text = item.password ?? ""
            iconImage.image = UIImage(named: "password-icon")
            usernameTextField.isSecureTextEntry = true
            usernameTextField.returnKeyType = .done
            
        default: break
        }
    }
    
}
