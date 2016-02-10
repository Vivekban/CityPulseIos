//
//  HomeTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 29/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class HomeTabViewController: BaseTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func setTabsParameter() {
        menuItemWithAccordingToText = true
        actionButton.setTitle("New Issue".localized, forState: .Normal)
        
        storyBoardName = "Home"
        // let tabs = CurrentSession.i.personUI?.nHomeTabs
        addTab("IssueViewController", title: "  \(MyStrings.community_issue)   ")
        addTab("IssueViewController", title: "  \(MyStrings.HOA_issue)     ")
        addTab("IssueViewController", title: "   \(MyStrings.polls)         ")

//        if tabs>3 {
//            addTab("IssueViewController", title: NSLocalizedString("Subscribed", comment: "Subscribed"))
//            addTab("IssueViewController", title: NSLocalizedString("Resolved", comment: "Resolved"))
//            
//        }
        
    }
    
    
    override func onActionButtonClick(sender: UIButton) {
        (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex)!] as? BaseNestedTabViewController)?.onActionButtonClick(sender)

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
