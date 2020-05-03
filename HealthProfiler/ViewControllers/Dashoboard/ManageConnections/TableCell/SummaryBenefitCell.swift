//
//  SummaryBenefitCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class SummaryBenefitCell: UITableViewCell {
    
    @IBOutlet var visitValue_label : UILabel!
    @IBOutlet var specialistValue_label : UILabel!
    @IBOutlet var ememrygencyRoomValue_label : UILabel!
    @IBOutlet var coinsuranceValue_label : UILabel!
    @IBOutlet var genericsValue_label : UILabel!
    @IBOutlet var brandedValue_label : UILabel!
    
    @IBOutlet var medicareBrief_view : UIView!
    @IBOutlet var pharmacyBrief_view : UIView!
    @IBOutlet var medicareDetail_button : UIButton!
    @IBOutlet var pharmacyDetail_button : UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}