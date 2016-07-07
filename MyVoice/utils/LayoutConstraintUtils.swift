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
    
    static func getTopContraint(view:UIView, container:UIView, value:CGFloat)->NSLayoutConstraint{
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: value)
    }
    
    static func getBottomContraint(view:UIView, container:UIView, value:CGFloat)->NSLayoutConstraint{
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: value)
    }

    static func getLeadingContraint(view:UIView, container:UIView, value:CGFloat)->NSLayoutConstraint{
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: value)
    }

    static func getTrailingContraint(view:UIView, container:UIView, value:CGFloat)->NSLayoutConstraint{
        
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: value)
    }
    
    static func getCenterXConstraint(view :UIView, container : UIView, value:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: value)

    }
    
    static func getCenterYConstraint(view :UIView, container : UIView, value:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: value)
        
    }


}


