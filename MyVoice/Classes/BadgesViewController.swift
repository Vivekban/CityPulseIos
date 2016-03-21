//
//  BadgesViewController.swift
//  MyVoice
//
//  Created by PB014 on 11/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class BadgesViewController: BaseProfileListViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        serverListRequestType = PersonInfoRequestType.Badges.rawValue
        tablView = tableView
        tableRowHeight = 50

        super.viewDidLoad()
        
        view.bringSubviewToFront(view.subviews[0])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func getTabsController() -> [UIViewController] {
        var cons = super.getTabsController()
        
        let con1 = UIViewController()
        con1.title = MyStrings.earned
        
        let con2 = UIViewController()
        con2.title = MyStrings.toBeEarned
        
        cons.append(con1)
        cons.append(con2)
        
        return cons
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
