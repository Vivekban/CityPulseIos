//
//  BaseProfileListViewController.swift
//  MyVoice
//
//  Created by PB014 on 11/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

/***
 concreate class has to set table height, tablView and serverListrequest
*/


class BaseProfileListViewController: BaseProfileNestedViewController {

    var tableRowHeight:CGFloat = 70
    var currentTab = 0
    var headerHeight = 0

    
    var tabsMenu:CAPSPageMenu?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tablView?.estimatedRowHeight = tableRowHeight
        tablView?.rowHeight = UITableViewAutomaticDimension
        
        expandedRows.insert(0)
        // detailControllerIdentifier = "MyViewDetailController"
        reuseIdentifier = "cell"
        
        if headerHeight > 0 {
             tablView?.tableHeaderView = tablView?.dequeueReusableCellWithIdentifier("header")?.contentView
        }
        
        let tabs = getTabsController()
        
        if tabs.count > 0 {
            let parameters: [CAPSPageMenuOption] = [
                .SelectionIndicatorColor(Constants.accentColor),
                .MenuHeight(50),
                .MenuItemSeparatorWidth(15),
                .SelectionIndicatorHeight(7),
                CAPSPageMenuOption.ScrollMenuBackgroundColor(UIColor.clearColor()),
                CAPSPageMenuOption.BottomMenuHairlineColor(UIColor.whiteColor())

            ]
            
            tabsMenu = CAPSPageMenu(viewControllers: tabs, frame: CGRect(x: 0, y: 3, width: self.view.frame.width, height: 50), pageMenuOptions: parameters)
            
            
            
            tabsMenu?.delegate = self
            
            
            tabsMenu?.view.backgroundColor = UIColor.clearColor()
            self.view.addSubview((tabsMenu?.view)!)
            view.sendSubviewToBack((tabsMenu?.view)!)
        }
        
        // menu creation

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabsMenu?.view.frame = CGRect(x: 0, y: 3, width: self.view.frame.width, height: 50)
        
    }
    
    func getTabsController() -> [UIViewController] {
        return [UIViewController]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        entries = CurrentSession.i.personController.person.getList(serverListRequestType!, index: currentTab).entries
        updateEntries()
        tablView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    
    
    
    override func configureTableCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        let d = entries[indexPath.row] 
            if let c = cell as? ActivityListCell {
                c.updateViewsWithData(d)
            }
        
    }

    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if headerHeight > 0 {
//        return tableView.dequeueReusableCellWithIdentifier("header")
//        }
//        return nil
//    }
    
    
    
}


class HitTestView : UIView {
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        print(".................")
        for i in subviews {
            let v = i.hitTest(point, withEvent: event)
            print("\(i.frame)......\(v)")
        }
        let view = super.hitTest(point, withEvent: event)
        return view
    }
}


extension BaseProfileListViewController : CAPSPageMenuDelegate{
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
        currentTab = index
    }
    
}

