//
//  PublicFigureTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 22/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class PublicFigureTabViewController: BaseTabViewController {

    override func viewDidLoad() {
        isBriefBar = false
        menuItemWidth = 150
        super.viewDidLoad()
        actionButton.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func getTabsController() -> [UIViewController] {
        
        storyBoardName = "Public Figure"
        
        
        var controllers = [UIViewController]()
        // Do any additional setup after loading the view.
        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        
        let controller : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("PublicFigureListController")
        controller.title = MyStrings.top_public_figure
        controllers.append(controller)
        
        let controller2 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("PublicFigureListController")
        controller2.title = MyStrings.my_public_figure
        controllers.append(controller2)
        
        
        
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
