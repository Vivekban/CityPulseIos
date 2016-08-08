//
//  StringLocalisationExtension.swift
//  MyVoice
//
//  Created by PB014 on 06/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation


extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    
    func doTrimming() -> String{
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    func length() -> Int {
        return characters.count
    }
    
}


extension Int {
    
    func toString() -> String {
        return String(self)
    }
    
}

extension NSDate {
    func numberOfDaysUntilDateTime(toDateTime: NSDate, inTimeZone timeZone: NSTimeZone? = nil) -> Int {
        let calendar = NSCalendar.currentCalendar()
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        
        var fromDate: NSDate?, toDate: NSDate?
        
        calendar.rangeOfUnit(.Day, startDate: &fromDate, interval: nil, forDate: self)
        calendar.rangeOfUnit(.Day, startDate: &toDate, interval: nil, forDate: toDateTime)
        
        let difference = calendar.components(.Day, fromDate: fromDate!, toDate: toDate!, options: [])
        return difference.day
    }
}

extension UIButton {
    
    func setTitleWithoutAnimation(title : String, forState: UIControlState){
        UIView.performWithoutAnimation({ () -> Void in
            self.setTitle(title, forState: forState)
            self.layoutIfNeeded()
            
        })
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}


extension UIView {
    
    func addWidthContraint(width:CGFloat) {
        addConstraint(LayoutConstraintUtils.getWidthContraint(self, width: width))
    }
    
    func addHeightContraint(height:CGFloat){
        addConstraint(LayoutConstraintUtils.getHeightContraint(self, height:height))
    }
    
    func pinViewOnAllDirection(view :UIView){
        
        addConstraint(LayoutConstraintUtils.getBottomContraint(view, container: self, value: 0))
        addConstraint(LayoutConstraintUtils.getLeadingContraint(view, container: self, value: 0))
        addConstraint(LayoutConstraintUtils.getTopContraint(view, container: self, value: 0))
        addConstraint(LayoutConstraintUtils.getTrailingContraint(view, container: self, value: 0))
        
    }
    
    
    func pinViewOnAllDirection(view :UIView, left:CGFloat,top:CGFloat,right:CGFloat,bottom:CGFloat){
        
        addConstraint(LayoutConstraintUtils.getBottomContraint(view, container: self, value:bottom))
        addConstraint(LayoutConstraintUtils.getLeadingContraint(view, container: self, value: left))
        addConstraint(LayoutConstraintUtils.getTopContraint(view, container: self, value: top))
        addConstraint(LayoutConstraintUtils.getTrailingContraint(view, container: self, value: right))
        
    }
    
    func pinViewToCenter(view :UIView) {
        addConstraint(LayoutConstraintUtils.getCenterXConstraint(view, container: self, value: 0))
        addConstraint(LayoutConstraintUtils.getCenterYConstraint(view, container: self, value: 0))

    }
    
    func constraintWithIdentifier(identifier : String) -> NSLayoutConstraint?{
        
        for constraint in self.constraints{
            if (constraint.identifier == identifier) {
                return constraint
            }
        }
        return nil
    }
    
    func getViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.nextResponder()
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

//class BoxedArray<T> : MutableCollectionType,Reflectable {
//    var array :Array<T> = []
//
//    subscript (index : Int) -> T {
//        get {
//            return array[index]
//        }
//        set (newValue) {
//            array[index] = newValue
//        }
//
//    }
//
//}