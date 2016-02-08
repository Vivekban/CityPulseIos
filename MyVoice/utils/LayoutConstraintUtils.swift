//
//  LayoutConstraintUtils.swift
//  MyVoice
//
//  Created by PB014 on 08/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class LayoutConstraintUtils {
    
   static func getWidthContraint(view:UIView, width:CGFloat)->NSLayoutConstraint{
        
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: width)
    }
    
   static func getHeightContraint(view:UIView, height:CGFloat)->NSLayoutConstraint{
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: height)
    }
}
