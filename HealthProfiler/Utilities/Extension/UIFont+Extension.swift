//
//  UIFont+Extension.swift
//  HealthProfiler
//

import Foundation
import UIKit

extension UIFont {

    class func regularFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
    
    class func mediumFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
    
    class func lightFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
    }

    class func ultraLightFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.ultraLight)
    }
    
    class func semiBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
    }
    
    class func italicFont(_ size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }
    
    class func boldFont(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize:size)
    }

    /*
     -- Custom fonts used within application
     */
    
    class func buttonFont_L1() -> UIFont {
        return UIFont.regularFont(18.0)
    }

    class func buttonFont_L2() -> UIFont {
        return UIFont.regularFont(13.0)
    }
    
    class func titleFont_L1() -> UIFont {
        return UIFont.regularFont(15.0)
    }
    
    class func titleFont_L2() -> UIFont {
        return UIFont.regularFont(13.0)
    }

    class func subTitleFont_L1() -> UIFont {
        return UIFont.lightFont(11.0)
    }
    
    class func subTitleFont_L2() -> UIFont {
        return UIFont.lightFont(9.0)
    }
    
    class func headerFont_L1() -> UIFont {
        return UIFont.semiBoldFont(30.0)
    }
    
    class func headerFont_L2() -> UIFont {
        return UIFont.semiBoldFont(27.0)
    }
    
    class func eventTitleFont() -> UIFont {
        return UIFont.semiBoldFont(22.0)
    }
    
    class func siteTitleFont() -> UIFont {
        return UIFont.semiBoldFont(18.0)
    }
    
    class func eventDateTitleFont() -> UIFont {
        return UIFont.regularFont(12.0)
    }
    
    class func pageDescriptionTitleFont() -> UIFont {
        return UIFont.regularFont(15.0)
    }
    
    class func italicTitleFont() -> UIFont {
        return UIFont.italicFont(12.0)
    }
    
    class func descriptionTitleFont() -> UIFont {
        return UIFont.regularFont(13.0)
    }
}
