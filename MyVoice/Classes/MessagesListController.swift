//
//  MessagesListController.swift
//  MyVoice
//
//  Created by PB014 on 14/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class MessagesListController: BaseNestedTabViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tablView = tableView
        
        
        if let navContr = self.navigationController {
            navContr.navigationBar.barTintColor = UIColor.whiteColor()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

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
