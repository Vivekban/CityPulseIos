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