//
//  HPCarePlanItem.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 14/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HPCarePlanItem: NSObject {
    
    var status: String?
    var interpretation: String?
    var careDescription: String?
    var finalscore: String?
    var question: String?
    var answer: String?
    var questions : Array<Any>?
    var questionData = [HPCarePlanQuestion]()

    init(_ data: Dictionary<String, Any>) {
        
        status = data.valueFor(key: "Status")
        interpretation = data.valueFor(key: "Interpretation")
        careDescription = data.valueFor(key: "Description")
        finalscore = data.valueFor(key: "Finalscore")
        questions = data.valueFor(key: "questions")
        for questionRaw in questions! {
            questionData.append(HPCarePlanQuestion(questionRaw as! Dictionary<String, Any>))
        }
    }
}

class HPCarePlanQuestion: NSObject {
    
    var question: String?
    var answer: String?
    
    init(_ data: Dictionary<String, Any>) {
        
        question = data.valueFor(key: "Question")
        answer = data.valueFor(key: "Answer")

    }
}
