//
//  UIColor+Extension.swift
//  HealthProfiler
//

import Foundation
import UIKit

extension UIColor {
    
    class func colorFromRGB(_ R : CGFloat,_ G : CGFloat,_ B : CGFloat,_ A: CGFloat = 1.0) -> UIColor {
        
        return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
    }
    
    //ref: http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios
    class func colorFromHex(_ hex:Int,_ alpha: CGFloat = 1.0) -> UIColor {
        
        //it only handles VALID 6 digit hex, need further improvement
        return UIColor.colorFromRGB(CGFloat((hex >> 16) & 0xff), CGFloat((hex >> 8) & 0xff), CGFloat(hex & 0xff), alpha)
    }
    
    /*
     -- Custom colors used within application
     */
    class func separatorColor() -> UIColor {
        return UIColor.colorFromHex(0xE4E4E4) // 'light gray'
    }
    
    class func cellSeparatorColor() -> UIColor {
        return UIColor.colorFromHex(0xF1F1F1) // 'light gray'
    }
    
    class func themeBackgroundColor() -> UIColor {
        return UIColor.colorFromRGB(245.0, 245.0, 245.0) //'light gray'
    }
    
    class func tableBackGroundColor() -> UIColor {
        return .white
    }
    
    class func errorColor() -> UIColor {
        return UIColor.colorFromHex(0xFF3B30) //'red orange' color
    }
    
    class func themePrimaryColor() -> UIColor {
        return UIColor.colorFromHex(0x1ABC9C) //'light sea green' simpplr theme color
    }
    
    class func textColor_dark()-> UIColor {
        return UIColor.black
    }
    
    class func textColor_normal()-> UIColor {
        return UIColor.colorFromHex(0x727272) //'dark gray'
    }
    
    class func textColor_description()-> UIColor {
        return UIColor.colorFromHex(0xC7C7CC) //'shade of dark gray'
    }
}
