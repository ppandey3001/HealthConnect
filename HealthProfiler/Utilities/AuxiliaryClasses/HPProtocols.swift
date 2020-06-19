//
//  HPProtocols.swift
//  HealthProfiler
//

import Foundation
import UIKit

//ref: https://medium.com/better-programming/5-useful-swift-extensions-to-use-in-your-ios-app-f54a817ea9a9
// MARK: - Reuse Identifiable
protocol ReuseIdentifiable {
    
    static func reuseableId() -> String
    static func nib() -> UINib
}

extension ReuseIdentifiable {
    
    static func reuseableId() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
