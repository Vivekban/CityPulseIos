//
//  TimeUtils.swift
//  MyVoice
//
//  Created by PB014 on 05/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class TimeDateUtils {
    static var formatter = NSDateFormatter()

    static func getServerStyleDateInString(date : NSDate) -> String{
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.stringFromDate(date)
        
    }
    
    static func getServerStyleDateInString(dateString : String) -> String{
        let f = NSDateFormatter()
        f.dateFormat = "MMM dd, yyyy"
        if let date = f.dateFromString(dateString) {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.stringFromDate(date)
        }
        log.error("error in parsing date")
        return ""
        
    }
    
    static func getClientStyleDateFromServerString(dateString : String) -> String{
        let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        if let date = f.dateFromString(dateString.componentsSeparatedByString(" ")[0]) {
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter.stringFromDate(date)
        }
        
        
        log.error("error in parsing date \(dateString)")
        return ""
        
    }
    
    
    static func getDateFromServerString(dateString : String) -> NSDate{
        let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        if let date = f.dateFromString(dateString.componentsSeparatedByString(" ")[0]) {
            return date
        }
        
        return NSDate()
        
    }

    
    
    static func getShortDateInString(date : NSDate) -> String{
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter.stringFromDate(date)
    }
    
    static func getStringFrom(date : NSDate, mode:UIDatePickerMode) -> String{
        
        switch (mode) {
        case .Date:
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            break
        case .Time:
            formatter.dateStyle = .NoStyle
            formatter.timeStyle = .ShortStyle
            break
        case .DateAndTime:
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .ShortStyle
            break
        case .CountDownTimer:
            formatter.dateStyle = .NoStyle
            formatter.timeStyle = .MediumStyle
            break
        }
        
        
        
        return formatter.stringFromDate(date)
    }
    
    static func getCurrentDateInlong() -> Double{
        return NSDate().timeIntervalSince1970
    }

}


