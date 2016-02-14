//
//  BaseTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class BaseTabViewController: UIViewController {
    
    let spaceInViews:CGFloat = 2
    
    // MARK: Tabs related parameters
    var topBar: TopBarView?
    var briefProfileView: BriefProfileBar?
    var tabsMenu:CAPSPageMenu?
    var tabTitles = [String]()
    var tabIndentifiers = [String]()
    var isBriefBar = true
    // MARK: properties
    
    var controllers:[UIViewController] = [UIViewController]()
    var storyBoardName:String = "Main"
    var tabsViewStartPoint :CGFloat = 0
    
    var menuItemWidth:CGFloat = 100
    var menuItemWithAccordingToText = false
    // action button particular to tab
    var actionButton : UIButton = UIButton(type: .System)
    
    // scrollView contentOffset
    
    weak var scrollView :UIScrollView?
    var scrollViewYOffset:CGFloat = -1
    var isScroll = false
    //
    var minTabsYpos:CGFloat = 0
    var maxTabsYpos:CGFloat = 0
    var tranlation:CGFloat = 0
    
    // additional view
    var additionalController:UIViewController?
    
    var currentActiveView:UIView?
    
    
    //
    
    
    deinit{
        log.debug("de int of base tab controller..............")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createActionButton()
        
        topBar = UINib(nibName: "TopBar", bundle: nil).instantiateWithOwner(self, options: nil)[0] as? TopBarView
        topBar?.delegate = self
        topBar?.frame = CGRectMake(0, 20, view.frame.width, 45)
        view.addSubview(topBar!)
        
        topBar?.cityField.text = CurrentSession.i.userPlacemark?.locality
        tabsViewStartPoint = ((topBar?.frame.origin.y)!) + (topBar!.frame.height)
        
        if isBriefBar {
            loadBriefView()
        }
        
        setTabsParameter()
        
        loadTabs()
        
        tabsMenu?.view.addSubview(actionButton)
        currentActiveView = tabsMenu?.view
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let i = tabsMenu?.currentPageIndex {
            didMoveToPage((tabsMenu?.controllerArray[i])!, index: i)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onViewScroll:", name: Constants.notification_center_scroll_key, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onViewScrollEvent:", name: Constants.notification_center_scroll_event_key, object: nil)
        
        EventUtils.addObserver(self, selector: Selector("onLocationUpdate"), key: EventUtils.locationUpdateKey)
        EventUtils.addObserver(self, selector: Selector("onBasicInfoUpdate"), key: EventUtils.basicInfoUpdateKey)

        
        log.info("adding observer...............\(tabTitles[0]).")
        
        
    }
    
    func onBasicInfoUpdate(){
        briefProfileView?.updateData(CurrentSession.i.personController.person.profileData)
    }
    
    func onLocationUpdate(){
        topBar?.cityField.text = CurrentSession.i.userPlacemark?.locality
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        log.info("removing observer..............\(tabTitles[0])..")

    }
    
    func onViewScrollEvent(sender:NSNotification){
        
        if let value = sender.object as? Int {
            isScroll = value == 1 ? true : false
            
            if !isScroll {
                scrollView = nil
            }
        }
        
    }
    
    func onViewScroll(sender:NSNotification){
        if let sv = sender.object as? UIScrollView {
            onScroll(sv)
            
            //            if (sv.panGestureRecognizer.velocityInView(sv.superview).y > 0){
            //                onScrollDown(sv)
            //            }
            //            else{
            //                onScrollUp(sv)
            //            }
            
        }
    }
    
    func onScroll(scrollView: UIScrollView){
        
        if !isBriefBar || !isScroll{
            return
        }
        
        
        if self.scrollView == nil || self.scrollView != scrollView || (scrollView.panGestureRecognizer.state == .Began) {
            scrollViewYOffset = scrollView.panGestureRecognizer.translationInView(scrollView.superview).y
            self.scrollView = scrollView
            tranlation = 0
            return
        }
        // print("tranlation...is \(scrollView.panGestureRecognizer.translationInView(scrollView.superview).y) and previos is \(tranlation)")
        
        
        let val = -scrollView.panGestureRecognizer.translationInView(scrollView.superview).y + tranlation
        // scrollViewYOffset += val
        tranlation = scrollView.panGestureRecognizer.translationInView(scrollView.superview).y
        
        
        
        let newTabsPos = max(minTabsYpos - spaceInViews, min(maxTabsYpos, tabsViewStartPoint - val))
        
        if newTabsPos != tabsViewStartPoint {
            
            let change = newTabsPos - tabsViewStartPoint
            
            var frame =  CGRectMake((briefProfileView?.frame.origin.x)!, (briefProfileView?.frame.origin.y)!, (briefProfileView?.frame.size.width)!, newTabsPos - minTabsYpos)
            frame.size.height = max(0,min(100,(frame.size.height)))
            
            briefProfileView?.frame = frame
            
            briefProfileView?.setNeedsDisplayInRect(frame)
            
            
            tabsViewStartPoint = newTabsPos
            
            var tabsFrame = currentActiveView?.frame
            
            tabsFrame?.size.height -= change
            tabsFrame?.origin.y += change
            
            currentActiveView?.frame = tabsFrame!
            
            view.setNeedsLayout()
        }
        
    }
    
    func onScrollDown(scrollView:UIScrollView){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createActionButton(){
        actionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        actionButton.titleLabel?.textColor = UIColor.whiteColor()
        actionButton.addTarget(self, action: Selector("onActionButtonClick:"), forControlEvents: .TouchUpInside)
        actionButton.frame = CGRect(x: (view.frame.width) - 100 - 15, y: 10, width: 100, height:30)
        actionButton.backgroundColor = Constants.accentColor
    }
    
    func loadBriefView(){
        
        briefProfileView =  BriefProfileBar.newInstance(self, type: (CurrentSession.i.personUI?.briefType)!, dataType: .TopBar,data: CurrentSession.i.personController.person.profileData)
        briefProfileView?.delegate = self
        
        minTabsYpos = (topBar?.frame.origin.y)! + (topBar?.frame.height)! + spaceInViews
        maxTabsYpos = minTabsYpos + 100
        
        briefProfileView?.frame = CGRectMake(0, minTabsYpos , view.frame.width, 100)
        view.addSubview(briefProfileView!)
        
        tabsViewStartPoint = ((briefProfileView?.frame.origin.y)!) + (briefProfileView!.frame.height)
        
    }
    
    func addTab(identifier:String , title:String){
        tabTitles.append(title)
        tabIndentifiers.append(identifier)
    }
    
    func onActionButtonClick(sender : UIButton){
        
    }
    
    
    func changeVisibilityOfActionButton(visible : Bool){
        actionButton.hidden = !visible
    }
    
    func setTitleOfActionButton(title : String){
        actionButton.setTitle(title, forState: .Normal)
    }
    
    
    
    // MARK: - Remove/Add Page
    func addAdditionView(controller: UIViewController) {
        // Call didMoveToPage delegate function
        
        if additionalController != nil {
            removeAdditionView()
        }
        
        additionalController = controller
        controller.willMoveToParentViewController(self)
        
        controller.view.frame = (tabsMenu?.view.frame)!
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        currentActiveView = controller.view
        controller.didMoveToParentViewController(self)
        topBar?.changeVisibiltOfBackButton(false)
    }
    
    func removeAdditionView() {
        if let oldVC = additionalController {
            oldVC.willMoveToParentViewController(nil)
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParentViewController()
        }
        currentActiveView = tabsMenu?.view
        topBar?.changeVisibiltOfBackButton(true)

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
            .MenuItemWidthBasedOnTitleTextWidth(menuItemWithAccordingToText),
            .MenuHeight(50),
            //.MenuItemSeparatorWidth(15),
            .SelectionIndicatorHeight(7),
            .MenuItemWidth(menuItemWidth)
        ]
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        
        
        tabsMenu = CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0, y: Int(tabsViewStartPoint + spaceInViews), width: Int(self.view.frame.width), height: Int(self.view.frame.height - tabsViewStartPoint - tabBarHeight - spaceInViews)), pageMenuOptions: parameters)
        
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
}

// MARK: - Brief Profile delegate

extension BaseTabViewController: BriefProfileBarDelegate {
    func onReviewClick() {
        if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") {
            addAdditionView(controller)
            topBar?.titleLabel.text = MyStrings.reviews
        }
    }
}

// MARK: - Top bar delegate

extension BaseTabViewController : TopBarViewDelegate {
    func onBackButtonClick() {
        if additionalController != nil {
            removeAdditionView()
        }
    }
    
    func onHelpButtonClick() {
        
    }
    
    func onCategoryChanged(text: String) {
        
    }
}


protocol TabsInitialisation {
    
    /// set storyboard name, add various tabs
    func setTabsParameter()
    
    /// create tabs for
    func loadTabs()
    
}



