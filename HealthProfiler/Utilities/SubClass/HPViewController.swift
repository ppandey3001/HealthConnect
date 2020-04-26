//
//  HPViewController.swift
//  HealthProfiler
//

import Foundation
import UIKit

/*
 This is base class for all the UIControllers added or to be added to the project
 
 This class can be used to log analytics events from one place,
 and can be helpfull to handle various common functions too
 */
class HPViewController: UIViewController {

    deinit {
        // make sure to remove the observer when this view controller is deinit
        NotificationCenter.default.removeObserver(self)
    }
}
