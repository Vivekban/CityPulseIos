//
//  BaseTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class BaseTabViewController: UIViewController {
    
    // MARK: Tabs related parameters
    var topBar: TopBarView?
    var briefProfileView: BriefProfileBar?
    var tabsMenu:CAPSPageMenu?
    var tabTitles = [String]()
    var tabIndentifiers = [String]()
    
    // MARK: properties
    
    var controllers:[UIViewController] = [UIViewController]()
    var storyBoardName:String = "Main"
    var tabsViewStartPoint :Int = 0
    
    // action button particular to tab
    var actionButton : UIButton = UIButton(type: .System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createActionButton()

        
        topBar = UINib(nibName: "TopBar", bundle: nil).instantiateWithOwner(self, options: nil)[0] as? TopBarView
        topBar?.frame = CGRectMake(0, 20, view.frame.width, 45)
        view.addSubview(topBar!)
        
        
        loadBriefView()
        
        setTabsParameter()
        
        loadTabs()
        
        tabsMenu?.view.addSubview(actionButton)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createActionButton(){
        actionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        actionButton.titleLabel?.textColor = UIColor.whiteColor()
        actionButton.addTarget(self, action: Selector("onActionButtonClick:"), forControlEvents: .TouchUpInside)
        actionButton.frame = CGRect(x: (view.frame.width) - 100 - 15, y: 8, width: 100, height:30)
        actionButton.backgroundColor = Constants.accentColor
    }
    
    func loadBriefView(){
        briefProfileView = UINib(nibName: (CurrentSession.i.personUI?.briefViewXibName)!, bundle: nil).instantiateWithOwner(self, options: nil)[0] as? BriefProfileBar
        briefProfileView?.frame = CGRectMake(0, (topBar?.frame.origin.y)! + (topBar?.frame.height)!, view.frame.width, 100)
        view.addSubview(briefProfileView!)
        
        tabsViewStartPoint = Int((briefProfileView?.frame.origin.y)!) + Int(briefProfileView!.frame.height)
        
    }
    
    func addTab(identifier:String , title:String){
        tabTitles.append(title)
        tabIndentifiers.append(identifier)
    }
    
    func onActionButtonClick(sender : UIButton){
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let i = tabsMenu?.currentPageIndex {
        didMoveToPage((tabsMenu?.controllerArray[i])!, index: i)
        }
    }
    
    func changeVisibilityOfActionButton(visible : Bool){
        actionButton.hidden = !visible
    }
    
    func setTitleOfActionButton(title : String){
        actionButton.setTitle(title, forState: .Normal)
    }
    
    /*
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
// MARK: CAPSMenuDelegate

extension BaseTabViewController : CAPSPageMenuDelegate{
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
    }
    
}

extension BaseTabViewController : TabsInitialisation{
    
    func setTabsParameter() {
        
    }
    
    func loadTabs(){
        // Do any additional setup after loading the view.
        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        
        
        for (i,identifier) in tabIndentifiers.enumerate() {
            let controller : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier(identifier)
            controller.title = tabTitles[i]
            controllers.append(controller)
        }
        
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(0),
            .SelectionIndicatorColor(Constants.accentColor),
            //.MenuItemWidthBasedOnTitleTextWidth(true),
            .MenuHeight(50),
            //.MenuMargin(25),
            .SelectionIndicatorHeight(7),
            .MenuItemWidth(90)
        ]
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        
        
        tabsMenu = CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0, y: tabsViewStartPoint, width: Int(self.view.frame.width), height: Int(self.view.frame.height)-tabsViewStartPoint - Int(tabBarHeight)), pageMenuOptions: parameters)
        
        tabsMenu?.delegate = self
        self.view.addSubview((tabsMenu?.view)!)
    }
}


protocol TabsInitialisation {
    
    /// set storyboard name, add various tabs
    func setTabsParameter()
    
    /// create tabs for
    func loadTabs()
    
}



