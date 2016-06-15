//
//  CommunityHubTabController.swift
//  MyVoice
//
//  Created by PB014 on 23/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class CommunityHubTabController: BaseTabsViewController  {

    override func viewDidLoad() {
        isBriefBar = false
        storyBoardName = "Community"
        super.viewDidLoad()
        actionButton.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        topBar?.setHiddenStatusOfCity(true)
    }
    
    override func getTabsController() -> [UIViewController] {
        
        
        var controllers = [UIViewController]()
        // Do any additional setup after loading the view.
        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        
        let controller : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("MyCommunityController")
        controller.title = MyStrings.myCommunity
        controllers.append(controller)
        
        let controller2 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("ListController")
        
        if let c = controller2 as? BaseNestedTabViewController {
            c.tabPosition = 1
        }
        
        controller2.title = MyStrings.topCommunity
        controllers.append(controller2)
        
        let controller3 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("ListController")
        controller3.title = MyStrings.topCommunityMember
        controllers.append(controller3)
        
        if let c = controller3 as? BaseNestedTabViewController {
            c.tabPosition = 2
        }

        let controller4 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("ListController")
        controller4.title = MyStrings.search
        controllers.append(controller4)
       
        if let c = controller4 as? BaseNestedTabViewController {
            c.tabPosition = 3
        }
        
        return controllers
        
    }

    override func didMoveToPage(controller: UIViewController, index: Int) {
        super.didMoveToPage(controller, index: index)
        topBar?.setTitle(controller.title ?? "")
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
