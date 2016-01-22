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
    
    static func getShortDateInString(date : NSDate) -> String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter.stringFromDate(date)
    }
    
    static func getStringFrom(date : NSDate, mode:UIDatePickerMode) -> String{
        let formatter = NSDateFormatter()
        
        switch (mode) {
        case .Date:
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            break
        case .Time:
            formatter.dateStyle = .NoStyle
            formatter.timeStyle = .ShortStyle
            break
        case .DateAndTime:
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .ShortStyle
            break
        case .CountDownTimer:
            formatter.dateStyle = .NoStyle
            formatter.timeStyle = .MediumStyle
            break
        }
        
        
        
        return formatter.stringFromDate(date)
    }
    
    static func getCurrentDateInlong() -> Double{
        return NSDate().timeIntervalSince1970
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
    
}
