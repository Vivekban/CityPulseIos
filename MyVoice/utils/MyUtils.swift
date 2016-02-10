//
//  MyUtils.swift
//  MyVoice
//
//  Created by PB014 on 01/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class MyUtils{
    
   
   
    static func getDatePicker(target: AnyObject?, selector:Selector) -> UIDatePicker{
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.addTarget(target, action: selector, forControlEvents: UIControlEvents.ValueChanged)
        
        return datePickerView
    }
    
    static func presentViewController(controller:UIViewController, identifier: String) -> UIViewController?{
        if let sectionController = controller.storyboard?.instantiateViewControllerWithIdentifier(identifier)
        {
            if let pController = controller.parentViewController {
                // controller.presentViewController(sectionController, animated: true, completion: nil)
                controller.view.window?.rootViewController?.presentViewController(sectionController, animated: true, completion: nil)
            }
            else{
                // controller.presentViewController(sectionController, animated: true, completion: nil)
                controller.view.window?.rootViewController?.presentViewController(sectionController, animated: true, completion: nil)
                
            }
            return sectionController
        }
        return nil
    }
    
    static func getViewControllerFromStoryBoard(storyBoadName : String, controllerName : String) -> UIViewController? {
        let aStoryboard =  UIStoryboard(name: storyBoadName, bundle: NSBundle.mainBundle())
        
        if controllerName.isEmpty {
           return aStoryboard.instantiateInitialViewController()
        }
        else{
           return aStoryboard.instantiateViewControllerWithIdentifier(controllerName)
        }
    }
    
       
    static func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        
        UIGraphicsBeginImageContext(sizeChange)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return scaledImage
    }
    
    
    static func getStatusBarHeight() -> CGFloat {
        return UIApplication().statusBarFrame.height
    }
    
    static func createShadowOnView(view : UIView){
        let shadowPath = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowPath = shadowPath.CGPath
    }
    
    static func makeNavigationBarTransparent(bar: UINavigationBar){
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.translucent = true
        //self.navigationController.view.backgroundColor = UIColor.clearColor()
    }
    
    static func delay(time:Double, work:()->()) {
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(),
            work)
    }
    
    static func appendKayToJSONString(string:String) -> String{
        return "{\"data\":\(string)}"

    }
    
    
    static func makeStringTrimmed(inputString :String) -> String{
        return inputString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    // MARK: - border
    static func createGreyBorder(view :UIView?, width:CGFloat = 1){
        if view != nil {
        view!.layer.borderWidth = width
            view?.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
    }

    
    
}
