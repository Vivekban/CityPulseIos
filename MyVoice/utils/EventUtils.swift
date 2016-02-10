//
//  EventUtils.swift
//  MyVoice
//
//  Created by PB014 on 10/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class EventUtils
{
    static var locationUpdateKey = "1"
    
    static func postNotification(key :String,  object :AnyObject? = nil){
        NSNotificationCenter.defaultCenter().postNotificationName(key, object: object)
    }
    
    static func addObserver(listener : AnyObject, selector: Selector, key: String, object: AnyObject? = nil){
        NSNotificationCenter.defaultCenter().addObserver(listener, selector: selector, name: key, object: object)
     }
    
    static func removeObserver(object :AnyObject){
        NSNotificationCenter.defaultCenter().removeObserver(object)
    }
    
    
    static func addObserForKeyBoardEvents(object : AnyObject) {
        NSNotificationCenter.defaultCenter().addObserver(object, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(object, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
}
