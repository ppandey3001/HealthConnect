//
//  Dictionary+Extensions.swift
//  HealthProfiler
//

import Foundation

public extension Dictionary {
    
    func valueFor<T>(key:Key) -> T? {
        
        let value = self[key]
        if value is T {
            return value as? T
        } else if ((value is NSNumber) && (T.self == String.self))  {
            return "\(String(describing: value))" as? T
        } else {
            return nil
        }
    }
    
    func JSONString() -> String? {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions())
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
            return jsonString
        } catch {
            return nil
        }
    }
    
    func JSONData() -> Data? {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
        } catch {
            return nil
        }
    }
}
