//
//  MainController.swift
//  MyVoice
//
//  Created by PB014 on 26/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
//        let firstStoryboard:UIStoryboard = UIStoryboard(name: "Me", bundle: nil)
//        let firstViewController:UIViewController = firstStoryboard.instantiateInitialViewController()!
//
//        self.viewControllers![1] = firstViewController
        
       
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Helvetica", size: CGFloat(15))!], forState:.Normal)
        //UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)

      //  UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.redColor()], forState:.Selected)

    }
    
    override func viewWillAppear(animated: Bool) {
   // let tabItemWidth = self.tabBar.itemWidth
    let image = UIImage(named: "tab_selected")
    
    UITabBar.appearance().selectionIndicatorImage = MyUtils.imageResize(image!, sizeChange: CGSize(width: 96, height: 47))
    // UITabBar.appearance().sele

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