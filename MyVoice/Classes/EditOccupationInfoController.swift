//
//  EditOccupationInfoController.swift
//  MyVoice
//
//  Created by PB014 on 09/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EditOccupationInfoController: EditBasicInfoViewController {
    
    @IBOutlet weak var posiitonSwitch: SevenSwitch!
    
    @IBOutlet weak var workingSwitch: SevenSwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        posiitonSwitch.onLabel.text = MyStrings.yes
        workingSwitch.onLabel.text = MyStrings.yes

        
        workingSwitch.offLabel.text = MyStrings.no
        posiitonSwitch.offLabel.text = MyStrings.no

        // Do any additional setup after loading the view.
    }
    
    override func fetchDataFromUIElements() {
        super.fetchDataFromUIElements()
        if let d = data as? PersonBasicData {
            d.isCurrentlyWorkingInOffice = workingSwitch.isOn()
            d.isPublicOffice = posiitonSwitch.isOn()
        }
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
