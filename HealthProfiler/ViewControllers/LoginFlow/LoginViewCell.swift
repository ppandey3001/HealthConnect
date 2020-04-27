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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
