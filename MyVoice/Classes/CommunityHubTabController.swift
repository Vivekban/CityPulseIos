//
//  CommunityHubTabController.swift
//  MyVoice
//
//  Created by PB014 on 23/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class CommunityHubTabController: BaseTabViewController  {

    override func viewDidLoad() {
        isBriefBar = false
        storyBoardName = "Community Hub"
        super.viewDidLoad()
        actionButton.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func getTabsController() -> [UIViewController] {
        
        
        var controllers = [UIViewController]()
        // Do any additional setup after loading the view.
        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        
        let controller : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("MyCommunityController")
        controller.title = MyStrings.myCommunity
        controllers.append(controller)
        
        let controller2 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("SearchListController")
        controller2.title = MyStrings.communities
        controllers.append(controller2)
        
        let controller3 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("ListController")
        controller3.title = MyStrings.topResident
        controllers.append(controller3)

        let controller4 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("ListController")
        controller3.title = MyStrings.topCommunity
        controllers.append(controller4)

        
        return controllers
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
