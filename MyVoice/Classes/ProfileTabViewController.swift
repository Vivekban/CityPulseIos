//
//  ProfileViewController.swift
//  MyVoice
//
//  Created by PB014 on 24/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class ProfileViewController: BaseTabsViewController {
    
    func ProfileViewController(){
    
    }
    
    override func viewDidLoad() {
        briefBarHeight = 78
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        // Do any additional setup after loading the view, typically from a nib.
        
        menuItemWidth = 80
        //CurrentSession.i.isEditingEnable = true;
        topBar?.changeVisibiltOfBackButton(false)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    override func getTabsController() -> [UIViewController] {
        storyBoardName = "Me"

        var controllers = [UIViewController]()
        // Do any additional setup after loading the view.
        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        
        if  let tabs = CurrentSession.i.personUI?.profileTabs {
            
            for i in tabs {
                // addTab(i.string_1 , title: i.string_2)
                let controller : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier(i.string_1)
                controller.title = i.string_2
                controllers.append(controller)
            }
        }
        return controllers
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
            break
        case 6:
            changeVisibilityOfActionButton(false)
        default:
            assertionFailure("pata ni")
        }
        
        topBar?.setTitle(controller.title ?? "")
        
        super.didMoveToPage(controller, index: index)
    }
    
    override func onActionButtonClick(sender: UIButton) {
        (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex)!] as? BaseNestedTabProtocoal)?.onActionButtonClick(sender)
    }
    
    
    func moveToProfileTab(){
        moveToTab((tabsMenu?.controllerArray.count)! - 1)
    }
    
    override func onBackButtonClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

