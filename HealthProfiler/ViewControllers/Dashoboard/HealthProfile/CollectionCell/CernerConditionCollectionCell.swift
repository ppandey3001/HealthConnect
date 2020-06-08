//
//  CernerConditionCollectionCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 05/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class CernerConditionCollectionCell: HPCollectionViewCell {
    
    @IBOutlet var evalutionValue_label : UILabel!
    @IBOutlet var goalValue_label : UILabel!
    @IBOutlet var lastVisitValue_label : UILabel!
    @IBOutlet var otherActionValue_label : UILabel!
    @IBOutlet var statusValue_label : UILabel!
    @IBOutlet var conditionValue_label : UILabel!
    @IBOutlet var background_view : UIView!
    
    func configureCell() {
        background_view?.layer.borderColor = UIColor.lightGray.cgColor
        background_view?.layer.borderWidth = 1.0
        background_view?.layer.cornerRadius = 5.0
    }

}

extension CernerConditionCollectionCell {
    func configureCernerConditionCell(item: HPCernerConditionItem) {
    
    let attributes = item.type.attributes()
        conditionValue_label.text = attributes.condition
        statusValue_label.text = attributes.status
        otherActionValue_label.text = attributes.otherActions
        goalValue_label.text = attributes.Goal
        evalutionValue_label.text = attributes.Evaluation
        lastVisitValue_label.text = attributes.lastVisit

    }
}
