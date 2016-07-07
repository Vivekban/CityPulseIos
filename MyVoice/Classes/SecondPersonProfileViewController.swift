//
//  SecondPersonProfileViewController.swift
//  MyVoice
//
//  Created by PB014 on 23/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class SecondPersonProfileViewController: ProfileViewController {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    func SecondPersonProfileViewController(){
        
    }
    
    override func viewDidLoad() {
        briefBarType = BriefProfileType.TopBarSecondPersonLeader
        super.viewDidLoad()
        briefBarHeight = 100

        topBar?.titleLabel.text = MyStrings.publicFigure
        topBar?.changeVisibiltOfBackButton(false)
        CurrentSession.i.isEditingEnable = false;
        
    }
    
    override func didMoveToPage(controller: UIViewController, index: Int) {
        changeVisibilityOfActionButton(false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        CurrentSession.i.isEditingEnable = false;
        
        EventUtils.addObserver(self, selector: "onBriefBarEvents:", key: EventUtils.briefBarActions)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        EventUtils.removeObserver(self)
    }
    
    
    func onBriefBarEvents(sender:NSNotification) {
        
        if let i = sender.object as? Int {
            
            switch (i) {
            case 1:
                onMessageClick()
                break;
            case 2:
                onFollowClick()
                break
            case 3:
                onReviewClick()
                break
            case 4:
                onDonationClick()
                break
            default:
                break;
            }
            
        }
        
    }
    
    
    override func onReviewClick() {
//        if (CurrentSession.i.isVisitingSomeone()){
//        super.onReviewClick()
//        }
//        else{
//            
//        }

    super.onReviewClick()
    }
    
    func onMessageClick() {
        
    }
    
    func onFollowClick() {
        
    }
    
    func onDonationClick() {
        
    }
    
    
    
    
    override func getTabsController() -> [UIViewController] {
        storyBoardName = "Me"
        
        var controllers = [UIViewController]()
        // Do any additional setup after loading the view.
        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let secondStoryboard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        
        if  let tabs = CurrentSession.i.personUI?.secondPersonProfileTabs {
            
            for i in tabs {
                let controller : UIViewController!
                if i.storyBoard == "Me" {
                    controller = firstStoryboard.instantiateViewControllerWithIdentifier(i.identifier)
                }
                else{
                    controller = secondStoryboard.instantiateViewControllerWithIdentifier(i.identifier)
                }
                controller.title = i.title
                controllers.append(controller)
            }
        }
        return controllers
    }
    
    override func onBackButtonClick() {
        dismissViewControllerAnimated(true, completion: nil)
        CurrentSession.i.isEditingEnable = true;
    }
    
}
