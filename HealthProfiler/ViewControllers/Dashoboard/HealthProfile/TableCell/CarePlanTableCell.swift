//
//  CarePlanTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 14/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class CarePlanTableCell: HPTableViewCell {
    
    @IBOutlet  var question_label : UILabel!
    @IBOutlet  var answer_label : UILabel!
}

extension CarePlanTableCell {
    
    func configureCarePlanCell(item: HPCarePlanQuestion , index: Int){
        answer_label.layer.cornerRadius = 12.0
        answer_label.layer.masksToBounds = true
        question_label.text = item.question
        answer_label.text = item.answer
    }
}
