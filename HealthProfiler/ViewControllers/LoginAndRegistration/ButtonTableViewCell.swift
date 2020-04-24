//
//  ButtonTableViewCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 20/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet var registerButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        signInButton.layer.cornerRadius = 12
        registerButton.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
