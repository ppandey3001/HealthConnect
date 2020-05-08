//
//  GeneralExtension.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 07/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import Foundation
// MARK:- Dictionary Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

extension Dictionary {
    mutating func unionInPlace(
        _ dictionary: Dictionary<Key, Value>) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
    
    mutating func unionInPlace<S: Sequence>(_ sequence: S) where S.Iterator.Element == (Key,Value) {
        for (key, value) in sequence {
            self[key] = value
        }
    }
    
    func stringForKey(_ key: Key) -> String {
        if let string = self[key] as? String {
            return string
        }
        
        return ""
    }
    
    func validatedValue(_ key: Key, expected: AnyObject) -> AnyObject {
        
        // checking if in case object is nil
        
        if let object = self[key] {
            
            // added helper to check if in case we are getting number from server but we want a string from it
            if object is NSNumber && expected is String {
                
                //Debug.log("case we are getting number from server but we want a string from it")
                
                return "\(object)" as AnyObject
            }
                
                // checking if object is of desired class
            else if ((object as AnyObject).isKind(of: expected.classForCoder) == false) {
                //Debug.log("case // checking if object is of desired class....not")
                
                return expected
            }
                
                // checking if in case object if of string type and we are getting nil inside quotes
            else if object is String {
                if ((object as! String == "null") || (object as! String == "<null>") || (object as! String == "(null)")) {
                    return "" as AnyObject
                }
            } else if object is Int {
                if ((object as! Int).description == "null" || (object as! Int).description == "<null>" || (object as! Int).description == "(null)") {
                    return 0 as AnyObject
                }
            } else if object is Float {
                if ((object as! Float).description == "null" || (object as! Float).description == "<null>" || (object as! Float).description == "(null)") {
                    return 0 as AnyObject
                }
            } else if object is Dictionary {
                if ((object as! Dictionary).description == "null" || (object as! Dictionary).description == "<null>" || (object as! Dictionary).description == "(null)") {
                    return [:] as AnyObject
                }
            } else if object is Array<Any> {
                if ((object as! Array<Any>).description == "null" || (object as! Array<Any>).description == "<null>" || (object as! Array<Any>).description == "(null)") {
                    return [] as AnyObject
                }
            } else if object is NSNumber {
                if ((object as! NSNumber).description == "null" || (object as! NSNumber).description == "<null>" || (object as! NSNumber).description == "(null)") {
                    return 0 as AnyObject
                }
            }
            return object as AnyObject
        } else {
            
            if expected is String {
                return "" as AnyObject
            } else if expected is Int || expected is Float {
                return 0 as AnyObject
            } else if expected is Dictionary {
                return [:] as AnyObject
            } else if expected is Array<Any> {
                return [] as AnyObject
            }
            
            return expected
        }
    }
    
}
