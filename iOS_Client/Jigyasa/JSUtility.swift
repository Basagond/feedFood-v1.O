//
//  JSUtility.swift
//  Jigyasa
//
//  Created by ajaybabu singineedi on 30/11/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

class JSUtility {
    static var formatter = DateFormatter()
    
    /*
     retuns key for from the plist
     */
    class func getStringValueWithKeyFromPlist(_ plist: String, key: String) -> String? {
        if let path: String = Bundle.main.path(forResource: plist, ofType: "plist"),
            let keyList = NSDictionary(contentsOfFile: path),
            let key = keyList[key] as? String {
            return key
        }
        return nil
    }
    
    /*
     Generate random string
     */
    class func randomStringWithLength (_ len : Int) -> String {
        
        let letters : String = "abcdefghijkmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUXYZ0123456789"
        var randomString = JSDefaultValues.defaultStringValue
        
        for _ in 0..<len {
            
            let length = UInt32(letters.characters.count)
            let rand = Int(arc4random_uniform(length))
            
            let char = letters[letters.characters.index(letters.startIndex, offsetBy: rand)]
            
            randomString.append(char)
        }
        
        return randomString
    }
    
    
    class func getBoolValueWithKeyFromPlist(_ plist: String, key: String) -> Bool? {
        if let path: String = Bundle.main.path(forResource: plist, ofType: "plist"),
            let keyList = NSDictionary(contentsOfFile: path),
            let key = keyList[key] as? Bool {
            return key
        }
        return nil
    }
    
    class func getDateFromString(inputDateString:String) ->Date? {
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let Pickup_To_Date = formatter.date(from: inputDateString)
        return Pickup_To_Date!
    }
    
    class func getStringFromDate(date:Date) -> String {
        formatter.dateStyle = DateFormatter.Style.short
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        let stringDate = formatter.string(from: date)
        return stringDate
    }
}
