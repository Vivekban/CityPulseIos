//
//  ReviewsTabController.swift
//  MyVoice
//
//  Created by PB014 on 10/04/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class ReviewsTabsController : MyTabsViewController {
    
    
    override func getTabsController() -> [UIViewController]{
        menuItemWithAccordingToText = true
        
        
        var controllers = [UIViewController]()
        // Do any additional setup after loading the view.
        
        if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") as? ReviewsViewController{
            controller.title = MyStrings.last7days
            controller.tabType = ReviewsViewControllerTabType.SevenDays
            controllers.append(controller)
        }
        
        if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") as? ReviewsViewController{
            controller.title = MyStrings.last30days
            controller.tabType = ReviewsViewControllerTabType.ThrityDays
            controllers.append(controller)
        }
        
        if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") as? ReviewsViewController{
            controller.title = MyStrings.last90days
            controller.tabType = ReviewsViewControllerTabType.NintyDays
            controllers.append(controller)
        }
        
        if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") as? ReviewsViewController{
            controller.title = MyStrings.allTime
            controller.tabType = ReviewsViewControllerTabType.AllTime
            controllers.append(controller)
        }
        
        
        
        return controllers
    }
    
    
}
