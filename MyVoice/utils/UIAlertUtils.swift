//
//  UIAlertUtils.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class UIAlertUtils {
    
    typealias AlertActionHandler = (UIAlertAction) -> Void
    
    static func createAlertFor(controller : UIViewController, with message : String , and actions :[UIAlertAction]){
        let alert:UIAlertController = UIAlertController(title: controller.title, message: message, preferredStyle:.Alert)
        for action in actions {
        alert.addAction(action)
        }
        controller.presentViewController(alert, animated:true, completion:nil);
    }
    
    static func createAlertFor(view : UIView, with message : String , and actions :[UIAlertAction]){
        createAlertFor(view.getViewController()!, with: message, and: actions)
    }

    
    static func createOkAlertFor(controller : UIViewController, with message : String){
        createAlertFor(controller, with: message, and: [UIAlertAction(title: MyStrings.ok, style: .Default, handler: nil)])

    }
    static func createOkAlertFor(view : UIView, with message : String){
        createAlertFor(view, with: message, and: [UIAlertAction(title: MyStrings.ok, style: .Default, handler: nil)])
        
    }
    
    static func createTryAgainWithCancelAlertFor(controller : UIViewController, with message : String, tryAgainHandler:AlertActionHandler){
        createAlertFor(controller, with: message, and: [UIAlertAction(title: MyStrings.cancel, style: .Default, handler: nil),
            UIAlertAction(title: MyStrings.tryAgain, style: .Default, handler: tryAgainHandler)])
    }
    
    static func createOkWithCancelAlertFor(controller : UIViewController, with message : String, tryAgainHandler:AlertActionHandler){
        createAlertFor(controller, with: message, and: [UIAlertAction(title: MyStrings.cancel, style: .Default, handler: nil),
            UIAlertAction(title: MyStrings.ok, style: .Default, handler: tryAgainHandler)])
    }
    
}