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
}


extension Int {
    
    func toString() -> String {
        return String(self)
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