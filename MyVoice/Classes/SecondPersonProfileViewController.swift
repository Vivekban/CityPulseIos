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
    
    override func viewDidLoad() {
        briefBarType = BriefProfileType.TopBarSecondPerson
        super.viewDidLoad()
        
        topBar?.titleLabel.text = MyStrings.publicFigure
        topBar?.changeVisibiltOfBackButton(false)
    }
    
    override func didMoveToPage(controller: UIViewController, index: Int) {
        changeVisibilityOfActionButton(false)
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
    }

}
