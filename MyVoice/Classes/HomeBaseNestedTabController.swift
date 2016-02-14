//
//  HomeBaseNestedTabController.swift
//  MyVoice
//
//  Created by PB014 on 11/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class HomeBaseNestedTabController: BaseNestedTabViewController {

    var currentFilter : HomeFilter? {
        didSet{
            onFilterChange()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serverDataManager = CurrentSession.i.issueController
        // Do any additional setup after loading the view.
        
    }


    func onFilterChange(){
        
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
