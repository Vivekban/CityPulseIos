//
//  MainController.swift
//  MyVoice
//
//  Created by PB014 on 26/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class MainController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        //ServerRequestInitiater.i.getUserDetail(["userId": "1"])
        
        // ServerRequestInitiater.i.valideUser(["email": "testing1@gmil.com","password":"dummy"])
        //        do{
        //       //let data = try NSJSONSerialization.dataWithJSONObject(json.rawValue, options: NSJSONWritingOptions.PrettyPrinted)
        //           //let string = NSString(data: data, encoding: NSUTF8StringEncoding)
        //
        //            print(json)
        //            print(json.rawString())
        //
        //           // ServerRequestInitiater.i.addUser(["data": json.rawString()!])
        //        }
        //        catch{
        //            print("asdfas")
        //        }
        
        
        // Do any additional setup after loading the view.
        //        let firstStoryboard:UIStoryboard = UIStoryboard(name: "Me", bundle: nil)
        //        let firstViewController:UIViewController = firstStoryboard.instantiateInitialViewController()!
        //
        //        self.viewControllers![1] = firstViewController
        
        
        if  !NSUserDefaults.standardUserDefaults().boolForKey(PermanentDataKey.isLoginDone) {
            
        }
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Helvetica", size: CGFloat(15))!], forState:.Normal)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().itemWidth = 100
        
        //UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        
        //  UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.redColor()], forState:.Selected)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // let tabItemWidth = self.tabBar.itemWidth
        let image = UIImage(named: "tab_selected")
        
        UITabBar.appearance().selectionIndicatorImage = MyUtils.imageResize(image!, sizeChange: CGSize(width: 100, height: 47))
        for item in self.tabBar.items! {
            item.image?.imageWithRenderingMode(.AlwaysOriginal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        // Get the new view controller using segue.destinationViewController.
    //        // Pass the selected object to the new view controller.
    //    }
    
    
}

extension MainController : UITabBarControllerDelegate{
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
    }
}