//
//  LoginViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 20/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class LoginViewCell: UITableViewCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var viewText: UIView!
    @IBOutlet var loginTextField: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
