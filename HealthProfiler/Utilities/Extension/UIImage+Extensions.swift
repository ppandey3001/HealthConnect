//
//  UIImage+Extensions.swift
//  HealthProfiler
//

import Foundation
import UIKit

extension UIImage {
    
    class func originalImage(name: String) -> UIImage? {
        return (UIImage(named: name)?.withRenderingMode(.alwaysOriginal))
    }
    
    class func templateImage(name:String) -> UIImage? {
        return (UIImage(named: name)?.withRenderingMode(.alwaysTemplate))
    }
    
    //bottom tab bar icon
    class func tabIcon_Activity() -> UIImage? {
        return UIImage.templateImage(name: "activity_icon")
    }
    
    class func tabIcon_Feed() -> UIImage? {
        return UIImage.templateImage(name: "feed")
    }
    
    class func tabIcon_Home() -> UIImage? {
        return UIImage.templateImage(name: "home")
    }
}

extension UIImage {
    
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}
