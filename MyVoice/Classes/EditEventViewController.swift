//
//  EditEventViewController.swift
//  MyVoice
//
//  Created by PB014 on 13/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EditEventViewController: BaseImageEditViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var name: FloatLabelTextField!
    @IBOutlet weak var startTime: FloatLabelTextField!
    @IBOutlet weak var endTime: FloatLabelTextField!
    @IBOutlet weak var allDaySwitch: UISwitch!
    @IBOutlet weak var location: FloatLabelTextField!
    @IBOutlet weak var webSite: FloatLabelTextField!
    @IBOutlet weak var descrip: FloatLabelTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popDatePickerTextFields.append(PopDatePickerParam(field: startTime, mode: UIDatePickerMode.DateAndTime))
        popDatePickerTextFields.append(PopDatePickerParam(field: endTime, mode: UIDatePickerMode.DateAndTime))
        collection = collectionView
        shadowObject.append(descrip)
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
