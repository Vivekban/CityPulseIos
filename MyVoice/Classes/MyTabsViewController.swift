//
//  MyTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 10/04/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol TabsInitialisation {
    
    /// set storyboard name, add various tabs
    func getTabsController() -> [UIViewController]
    
    /// create tabs for
    func loadTabs()
    
}

class MyTabsViewController : UIViewController{
    
    let spaceInViews:CGFloat = 2
    
    
    var tabsMenu:CAPSPageMenu?
    
    // var tabTitles = [String]()
    // var tabIndentifiers = [String]()
    
    var tabsViewStartPoint :CGFloat = 0
    
    
    var menuItemWidth:CGFloat = 100
    var menuItemWithAccordingToText = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabs()
    }
}


extension MyTabsViewController : TabsInitialisation{
    
    func getTabsController() -> [UIViewController]{
        return [UIViewController]()
    }
    
    func loadTabs(){
        
        let controllers = getTabsController()
        
        let parameters: [CAPSPageMenuOption] = [
            .SelectionIndicatorColor(Constants.accentColor),
            .MenuHeight(50),
            .MenuItemSeparatorWidth(0),
            .SelectionIndicatorHeight(7),
        ]
        
        // let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        
        
        tabsMenu = CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0, y: Int(tabsViewStartPoint + spaceInViews), width: Int(self.view.frame.width), height: Int(self.view.frame.height - tabsViewStartPoint - spaceInViews)), pageMenuOptions: parameters)
        
        
        
        tabsMenu?.delegate = self
        
        
        
        self.view.addSubview((tabsMenu?.view)!)
        
        //        if (isBriefBar) {
        //
        //            if let tabsView = tabsMenu?.view {
        //
        //                NSLayoutConstraint(item: tabsView, attribute: .Top, relatedBy: .Equal, toItem: briefProfileView, attribute: .Bottom, multiplier: 1, constant: 10).active = true
        //            }
        //        }
    }
    
    
    func moveToTab(index : Int) {
        if tabsMenu?.controllerArray.count > index {
            tabsMenu?.moveToPage(index)
            tabsMenu?.moveSelectionIndicator(index)
            ((tabsMenu?.controllerArray[index]) as? BaseNestedTabViewController)?.isVisible = true
        }
        else {
            assertionFailure("invalid tab")
        }
    }
}

// MARK: CAPSMenuDelegate

extension MyTabsViewController : CAPSPageMenuDelegate{
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
    }
    
}



