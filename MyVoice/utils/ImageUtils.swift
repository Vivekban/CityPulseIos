//
//  ImageUtils.swift
//  MyVoice
//
//  Created by PB014 on 10/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

    extension UIImage {
       
        class func imageWithColor(color: UIColor, rect:CGRect = CGRectMake(0.0, 0.0, 1.0, 1.0)) -> UIImage {
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            
            CGContextSetFillColorWithColor(context, color.CGColor)
            CGContextFillRect(context, rect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image
        }

    }

