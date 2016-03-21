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
    var lastScrollDirection = 0
    //
    var minTabsYpos:CGFloat = 0
    var maxTabsYpos:CGFloat = 0
    var tranlation:CGFloat = 0
    
    // additional view
    var additionalController:UIViewController?
    
    var currentActiveView:UIView?
    
    var briefBarType:BriefProfileType = .TopBar
    
    //
    
    
    deinit{
        log.debug("de int of base tab controller..............")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createActionButton()
        
        topBar = NSBundle.mainBundle().loadNibNamed("TopBar", owner: TopBarView.self, options: nil)[0] as? TopBarView//UINib(nibName: "TopBar", bundle: nil).instantiateWithOwner(TopBarView.self, options: nil)[0] as? TopBarView
        topBar?.delegate = self
        topBar?.controller = self
        topBar?.frame = CGRectMake(0, 20, view.frame.width, 45)
        topBar?.cityField.text = CurrentSession.i.userPlacemark?.locality
        tabsViewStartPoint = ((topBar?.frame.origin.y)!) + (topBar!.frame.height)
        
        if isBriefBar {
            loadBriefView()
        }
        
        
        loadTabs()
        
        tabsMenu?.view.addSubview(actionButton)
        currentActiveView = tabsMenu?.view
        
        let lineBelowTopBar = UIView(frame: CGRectMake(0, 65, view.frame.width, 2))
        lineBelowTopBar.backgroundColor = view.backgroundColor
        view.addSubview(lineBelowTopBar)
        
        
        // higest z order
        view.addSubview(topBar!)
        
        view.autoresizingMask = UIViewAutoresizing.None
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        log.debug("Start.............First view appear...\(topBar?.frame)...")
        topBar?.frame = CGRectMake(0, 20, view.frame.width, 45)
        briefProfileView?.frame = CGRectMake(0, minTabsYpos , view.frame.width, 100)
        
        super.viewDidAppear(animated)
        if let i = tabsMenu?.currentPageIndex {
            didMoveToPage((tabsMenu?.controllerArray[i])!, index: i)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onViewScroll:", name: Constants.notification_center_scroll_key, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onViewScrollEvent:", name: Constants.notification_center_scroll_event_key, object: nil)
        
        EventUtils.addObserver(self, selector: Selector("onLocationUpdate"), key: EventUtils.locationUpdateKey)
        EventUtils.addObserver(self, selector: Selector("onBasicInfoUpdate"), key: EventUtils.basicInfoUpdateKey)
        
        
        
        
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
        
        
    }
    
    func onViewScrollEvent(sender:NSNotification){
        
        if let value = sender.object as? Int {
            
            if value == 2 {
                onDraggingStop()
            }
            
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
            tranlation = 0//scrollView.panGestureRecognizer.translationInView(scrollView.superview).y
            return
        }
        // print("tranlation...is \(scrollView.panGestureRecognizer.translationInView(scrollView.superview).y) and previos is \(tranlation)")
        
        let val = scrollView.panGestureRecognizer.translationInView(scrollView.superview).y - tranlation
        // scrollViewYOffset += val
        tranlation = scrollView.panGestureRecognizer.translationInView(scrollView.superview).y
        
        lastScrollDirection = Int(tranlation)
        
        
        let newTabsPos = max(minTabsYpos - spaceInViews, min(maxTabsYpos, tabsViewStartPoint + val))
        
        if newTabsPos != tabsViewStartPoint {
            
            let change = newTabsPos - tabsViewStartPoint
            
            scrollView.contentOffset.y += change
            
            // var frame =  CGRectMake((briefProfileView?.frame.origin.x)!, (briefProfileView?.frame.origin.y)!, (briefProfileView?.frame.size.width)!, newTabsPos - minTabsYpos)
            // frame.size.height = max(0,min(100,(frame.size.height)))
            
            briefProfileView?.frame.origin.y += change
            
            //   briefProfileView?.setNeedsDisplayInRect(frame)
            
            
            tabsViewStartPoint = newTabsPos
            
            var tabsFrame = currentActiveView?.frame
            
            tabsFrame?.size.height -= change
            tabsFrame?.origin.y += change
            
            currentActiveView?.frame = tabsFrame!
            
            view.setNeedsLayout()
        }
        
    }
    
    
    func onDraggingStop(){
        if !isBriefBar {
            return
        }
        view.layer.removeAllAnimations()
        if lastScrollDirection < 0 {
            
            
            let newTabsPos = minTabsYpos - spaceInViews
            
            if newTabsPos != tabsViewStartPoint {
                
                let change = newTabsPos - tabsViewStartPoint
                let time = change/50
                // print(change)
                
                UIView.animateWithDuration(NSTimeInterval(time), animations: { () -> Void in
                    
                    self.animateView(change)
                })
            }
            
        }
        else {
            let newTabsPos = maxTabsYpos
            
            if newTabsPos != tabsViewStartPoint {
                let change = newTabsPos - tabsViewStartPoint
                let time = change/400
                 
                tabsViewStartPoint = maxTabsYpos

                
                UIView.animateWithDuration(NSTimeInterval(time), animations: { () -> Void in
                    
                    //self.animateView(change)
                    
                    self.briefProfileView?.frame.origin.y =  self.minTabsYpos - self.spaceInViews
                    
                    var tabsFrame = self.currentActiveView?.frame
                    tabsFrame?.origin.y = self.maxTabsYpos
                    tabsFrame?.size.height = self.view.frame.height - self.maxTabsYpos

                    self.currentActiveView?.frame = tabsFrame!
                    self.view.setNeedsLayout()
                  
                })
            }
        }
        
    }
    
    func animateView(change : CGFloat) {
        
        briefProfileView?.frame.origin.y += change
        
        var tabsFrame = currentActiveView?.frame
        tabsFrame?.size.height -= change
        tabsFrame?.origin.y += change
        tabsViewStartPoint = (tabsFrame?.origin.y)!
        
        currentActiveView?.frame = tabsFrame!
        view.setNeedsLayout()
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
        
        briefProfileView =  BriefProfileBar.newInstance(self, type: (CurrentSession.i.personUI?.briefType)!, barType: briefBarType,data: CurrentSession.i.personController.person.profileData)
        briefProfileView?.delegate = self
        
        minTabsYpos = (topBar?.frame.origin.y)! + (topBar?.frame.height)! + spaceInViews
        maxTabsYpos = minTabsYpos + 100
        
        briefProfileView?.frame = CGRectMake(0, minTabsYpos , view.frame.width, 100)
        
        briefProfileView?.updateData(CurrentSession.i.personController.person.profileData)
        
        
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
        topBar?.titleLabel.text = controller.title

        additionalController = controller
        // controller.willMoveToParentViewController(self)
        
        controller.view.frame = (tabsMenu?.view.frame)!
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        currentActiveView = controller.view
        controller.didMoveToParentViewController(self)
        topBar?.changeVisibiltOfBackButton(false)
        tabsMenu?.view.hidden = true
    }
    
    func removeAdditionView() {
        if let oldVC = additionalController {
            tabsMenu?.view.frame = (currentActiveView?.frame)!
            oldVC.willMoveToParentViewController(nil)
            oldVC.view.removeFromSuperview()
            oldVC.removeFromParentViewController()
        }
        currentActiveView = tabsMenu?.view
        topBar?.changeVisibiltOfBackButton(true)
        tabsMenu?.view.hidden = false

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
        //lastScrollDirection = 1
        // onDraggingStop()
    }
    
}

extension BaseTabViewController : TabsInitialisation{
    
    func getTabsController() -> [UIViewController]{
        return [UIViewController]()
    }
    
    func loadTabs(){
        
        let controllers = getTabsController()
               
        let parameters: [CAPSPageMenuOption] = [
            .SelectionIndicatorColor(Constants.accentColor),
            .MenuHeight(50),
            .MenuItemSeparatorWidth(15),
            .SelectionIndicatorHeight(7),
        ]
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        
        
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

// MARK: - Brief Profile delegate

extension BaseTabViewController: BriefProfileBarDelegate {
    func onReviewClick() {
        
        if CurrentSession.i.isVisitingSomeone() {
            if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "EditReviewController") as? BaseEditViewController {
                var data : [BaseData] = [BaseData]()
                controller.setDataSourceWith(.NEW, data: &data, index: -1)
                controller.title = MyStrings.write_review
                addAdditionView(controller)
            }
        }
        else{
            
            if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") {
                controller.title = MyStrings.reviews
                addAdditionView(controller)
            }
        }
    }
}

// MARK: - Top bar delegate

extension BaseTabViewController : TopBarViewDelegate {
    func onBackButtonClick() {
        if additionalController != nil {
            removeAdditionView()
        }
        // onDraggingStop()
    }
    
    func onHelpButtonClick() {
        
    }
    
    func onCategoryChanged(text:String, item index:Int) {
        
    }
}


protocol TabsInitialisation {
    
    /// set storyboard name, add various tabs
    func getTabsController() -> [UIViewController]
    
    /// create tabs for
    func loadTabs()
    
}



