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
        menuItemWidth = 150
        storyBoardName = "Community Hub"
        super.viewDidLoad()
        actionButton.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setTabsParameter() {
        addTab("MyCommunityController", title: MyStrings.myCommunity)
        addTab("SearchListController", title: MyStrings.communities)
        addTab("ListController", title: MyStrings.topResident)
        addTab("ListController", title: MyStrings.topCommunity)

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
