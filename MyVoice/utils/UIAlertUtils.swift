//
//  UIAlertUtils.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class UIAlertUtils {
    
    public typealias AlertActionHandler = (UIAlertAction) -> Void
    
    static func createAlertFor(controller : UIViewController, with message : String , and action :UIAlertAction){
        let alert:UIAlertController = UIAlertController(title: controller.title, message: message, preferredStyle:.Alert)
        alert.addAction(action)
        controller.presentViewController(alert, animated:true, completion:nil);
    }
    
    static func createOkAlertFor(controller : UIViewController, with message : String){
        createAlertFor(controller, with: message, and: UIAlertAction(title: "Ok".localized, style: .Default, handler: nil))
    }
    
    
}