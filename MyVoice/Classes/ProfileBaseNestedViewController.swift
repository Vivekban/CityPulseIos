//
//  BaseProfileNestedViewController.swift
//  MyVoice
//
//  Created by PB014 on 15/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class BaseProfileNestedViewController: BaseNestedTabViewController {

    override func viewDidLoad() {
        serverDataManager = CurrentSession.i.personController
        super.viewDidLoad()

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


class BaseProfileHeaderCollectionView :BaseHeaderCollectionView {
    
    override func viewDidLoad() {
        serverDataManager = CurrentSession.i.personController
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}