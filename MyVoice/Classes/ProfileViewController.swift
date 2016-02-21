//
//  ProfileViewController.swift
//  MyVoice
//
//  Created by PB014 on 24/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class ProfileViewController: BaseTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    
    
    override func setTabsParameter() {
        storyBoardName = "Me"
        
        if  let tabs = CurrentSession.i.personUI?.profileTabs {
        
        for i in tabs {
            addTab(i.string_1 , title: i.string_2)

        }
        }
        
//        addTab("MyViews", title: "My Views")
//        addTab("MyWorkViewController", title: "My Work")
//        addTab("EventViewController", title: "Events")
    }

    override func willMoveToPage(controller: UIViewController, index: Int) {
       changeVisibilityOfActionButton(false)
    }
    
    override func didMoveToPage(controller: UIViewController, index: Int) {
        print(index)
        switch index {
            
        case 4,3: // info
            changeVisibilityOfActionButton(false)
            break
        case 1:
            changeVisibilityOfActionButton(true)
            setTitleOfActionButton("Add_Views".localized)
            break
            
        case 0:
            changeVisibilityOfActionButton(true)
            setTitleOfActionButton("Add_Work".localized)
            break
        case 2:
            changeVisibilityOfActionButton(true)
            setTitleOfActionButton("ADD_EVENT".localized)
            break
        case 5:
            changeVisibilityOfActionButton(true)
            setTitleOfActionButton("ADD_VIDEO".localized)
        default:
            assertionFailure("pata ni")
        }
    }
    
    override func onActionButtonClick(sender: UIButton) {
        (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex)!] as? BaseNestedTabProtocoal)?.onActionButtonClick(sender)
    }
    
}

