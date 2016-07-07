//
//  BaseTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit



class BaseTabsViewController: MyTabsViewController {
    
    
    // MARK: Tabs related parameters
    var topBar: TopBarView?
    var briefProfileView: BriefProfileBar?
    var isBriefBar = true
    var briefBarHeight:CGFloat = 100
    
    // MARK: properties
    
    var storyBoardName:String = "Main"
    
    
    // action button particular to tab
    var actionButton : UIButton = UIButton(type: .System)
    
    // scrollView contentOffset
    
    weak var scrollView :UIScrollView?
    var scrollViewYOffset:CGFloat = -1
    var isScroll = false
    var lastScrollDirection = 0
    var scrollViewContentOffset:CGFloat = 0
    //
    var minTabsYpos:CGFloat = 0
    var maxTabsYpos:CGFloat = 0
    var tranlation:CGFloat = 0
    
    // additional view
    var additionalController:UIViewController?
    
    var currentActiveView:UIView?
    
    var briefBarType:BriefProfileType = .TopBarLeader
    
    //
    
    
    deinit{
        log.debug("de int of base tab controller..............")
    }
    
    
    override func viewDidLoad() {
        
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
        
        
        super.viewDidLoad()

        
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
        log.debug("Start.............First view appear...\(briefProfileView?.frame)...")
        topBar?.frame = CGRectMake(0, 20, view.frame.width, 45)
        briefProfileView?.frame = CGRectMake(0, minTabsYpos , view.frame.width, briefBarHeight)
        log.debug("after....Start.............First view appear...\(briefProfileView?.frame)...")

        super.viewDidAppear(animated)
        if let i = tabsMenu?.currentPageIndex {
            didMoveToPage((tabsMenu?.controllerArray[i])!, index: i)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseTabsViewController.onViewScroll(_:)), name: Constants.notification_center_scroll_key, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseTabsViewController.onViewScrollEvent(_:)), name: Constants.notification_center_scroll_event_key, object: nil)
        
        EventUtils.addObserver(self, selector: #selector(BaseTabsViewController.onLocationUpdate), key: EventUtils.locationUpdateKey)
        EventUtils.addObserver(self, selector: #selector(BaseTabsViewController.onBasicInfoUpdate), key: EventUtils.basicInfoUpdateKey)
        
        
        
        
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
                if tabsViewStartPoint != minTabsYpos - spaceInViews && tabsViewStartPoint != maxTabsYpos {
                onDraggingStop()
                }
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
            scrollViewContentOffset = scrollView.contentOffset.y
            return
        }
        //print("tranlation...is \(scrollView.panGestureRecognizer.translationInView(scrollView.superview).y) and previos is \(tranlation)")
        
        let val = scrollView.panGestureRecognizer.translationInView(scrollView.superview).y   - tranlation
        // scrollViewYOffset += val
        tranlation = scrollView.panGestureRecognizer.translationInView(scrollView.superview).y
        
        lastScrollDirection = Int(tranlation)
        
        
        let newTabsPos = max(minTabsYpos - spaceInViews, min(maxTabsYpos, tabsViewStartPoint + val))
        
        
        print(scrollView.contentOffset.y - scrollViewContentOffset)
        
        
        if newTabsPos != tabsViewStartPoint {
            
            if !(tabsViewStartPoint == minTabsYpos - spaceInViews && scrollView.contentOffset.y > 0) {
                
                let change = newTabsPos - tabsViewStartPoint
                
                // var frame =  CGRectMake((briefProfileView?.frame.origin.x)!, (briefProfileView?.frame.origin.y)!, (briefProfileView?.frame.size.width)!, newTabsPos - minTabsYpos)
                // frame.size.height = max(0,min(briefBarHeight,(frame.size.height)))
                //   briefProfileView?.setNeedsDisplayInRect(frame)
                
                
                tabsViewStartPoint = newTabsPos
                
                var tabsFrame = currentActiveView?.frame
                
                tabsFrame?.size.height -= change
                tabsFrame?.origin.y += change
                briefProfileView?.frame.origin.y = (tabsFrame?.origin.y)! - (briefProfileView?.frame.height)! - spaceInViews
                
                
                currentActiveView?.frame = tabsFrame!
                
                scrollView.contentOffset.y += change

                view.setNeedsLayout()
            }
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
           showBriefBar(true)
        }
        
    }
    
    
    func showBriefBar(isAnimate : Bool){
        let newTabsPos = maxTabsYpos
        if newTabsPos != tabsViewStartPoint {
            let change = newTabsPos - tabsViewStartPoint
            let time = isAnimate ? change/400 : 0
            
            tabsViewStartPoint = maxTabsYpos
            
            
            UIView.animateWithDuration(NSTimeInterval(time), animations: { () -> Void in
                
                //self.animateView(change)
                
                self.briefProfileView?.frame.origin.y =  self.minTabsYpos
                
                var tabsFrame = self.currentActiveView?.frame
                tabsFrame?.origin.y = self.maxTabsYpos + self.spaceInViews
                tabsFrame?.size.height = self.view.frame.height - self.maxTabsYpos - self.spaceInViews
                
                self.currentActiveView?.frame = tabsFrame!
                self.view.setNeedsLayout()
                
            })
            
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
        //actionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        actionButton.highlighted = false
        actionButton.titleLabel?.textColor = UIColor.whiteColor()
        actionButton.addTarget(self, action: Selector("onActionButtonClick:"), forControlEvents: .TouchUpInside)
        actionButton.frame = CGRect(x: (view.frame.width) - 100 - 15, y: 10, width: 100, height:30)
        actionButton.backgroundColor = Constants.accentColor
        
    }
    
    func loadBriefView(){
        
        briefProfileView =  BriefProfileBar.newInstance(self, barType: briefBarType, data: CurrentSession.i.personController.person.profileData)
        briefProfileView?.delegate = self
        
        minTabsYpos = (topBar?.frame.origin.y)! + (topBar?.frame.height)! + spaceInViews
        maxTabsYpos = minTabsYpos + briefBarHeight
        
        briefProfileView?.frame = CGRectMake(0, minTabsYpos , view.frame.width, briefBarHeight)
        
        briefProfileView?.updateData(CurrentSession.i.personController.person.profileData)
        
        
        view.addSubview(briefProfileView!)
        
        tabsViewStartPoint = ((briefProfileView?.frame.origin.y)!) + (briefProfileView!.frame.height)
        
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
        showBriefBar(false)
        
    }
    
    
    
    /*
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}


// MARK: - Brief Profile delegate

extension BaseTabsViewController: BriefProfileBarDelegate {
    func onReviewClick() {
        
        if !CurrentSession.i.isEditingEnable {
            if let controller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "EditReviewController") as? BaseEditViewController {
                var data : [BaseData] = [BaseData]()
                controller.setDataSourceWith(.NEW, data: &data, index: -1)
                controller.title = MyStrings.write_review
                addAdditionView(controller)
            }
        }
        else{
            
             let controller = ReviewsTabsController()
                controller.title = MyStrings.reviews
                addAdditionView(controller)
            
        }
    }
}

// MARK: - Top bar delegate

extension BaseTabsViewController : TopBarViewDelegate {
    func onBackButtonClick() {
        if additionalController != nil {
            removeAdditionView()
        }
        // onDraggingStop()
    }
    
    func onNotifiactionClick(index: Int){
        
    }
    
    func onProfileButtonClick(){
        let controller = ProfileViewController()
        MyUtils.presentViewControllerOnRoot(self, newController: controller)
    }
}






