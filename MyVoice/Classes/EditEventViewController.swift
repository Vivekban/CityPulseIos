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
    @IBOutlet weak var descrip: DescriptionView!
    
    @IBOutlet weak var endTimeLayout: UIView!
    override func viewDidLoad() {
        mainTitle = MyStrings.event

        super.viewDidLoad()
        popDatePickerTextFields.append(PopDatePickerParam(field: startTime, mode: UIDatePickerMode.DateAndTime))
        popDatePickerTextFields.append(PopDatePickerParam(field: endTime, mode: UIDatePickerMode.DateAndTime))
        collection = collectionView
        // shadowObject.append(descrip)
        
        addItemUrl = ServerUrls.addEventUrl
        updateItemUrl = ServerUrls.updateEventUrl
        
        allDaySwitch.addTarget(self, action: #selector(EditEventViewController.onSwitchChange), forControlEvents: UIControlEvents.ValueChanged)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getDataForNewItem() -> BaseData {
        return EventData()
    }
    
    override func fetchDataFromUIElements() {
        if let d = data as? EventData {
            d.title = name.text ?? ""
            d.description = descrip.text
            d.startTime = startTime.text ?? ""
            d.endTime = endTime.text ?? ""
         //   d.location = location.text
            d.website = webSite.text ?? ""
            d.allDayEvent = allDaySwitch.on
        }
        else{
            assertionFailure("wron data type")
        }
    }
    
    override func initialiseViews() {
        super.initialiseViews()
        if let d = data as? EventData {
           name.text = d.title
           descrip.text = d.description
           startTime.text = d.startTime
            endTime.text = d.endTime
            //   d.location = location.text
            webSite.text = d.website
           allDaySwitch.setOn(d.allDayEvent, animated: false)
        }
        onSwitchChange()
    }

    
    func onSwitchChange(){
       
        endTimeLayout.hidden = allDaySwitch.on

    }
    
    
    override func getMinimunDateForField(textfield : UITextField) -> NSDate {
        
        if textfield == endTime {
            
            return TimeDateUtils.getDateFrom(startTime.text ?? "", mode: UIDatePickerMode.DateAndTime)
        
        }
        
        return super.getMinimunDateForField(textfield)
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
