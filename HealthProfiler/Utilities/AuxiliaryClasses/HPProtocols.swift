//
//  HPProtocols.swift
//  HealthProfiler
//

import Foundation
import UIKit

//ref: https://medium.com/better-programming/5-useful-swift-extensions-to-use-in-your-ios-app-f54a817ea9a9
// MARK: - Reuse Identifiable
protocol ReuseIdentifiable {
    static func reuseIdentifier() -> String
}

extension ReuseIdentifiable {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

// MARK: - UITableViewCell & UICollectionViewCell
extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
