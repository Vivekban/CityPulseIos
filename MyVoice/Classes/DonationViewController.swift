//
//  DonationViewController.swift
//  MyVoice
//
//  Created by PB014 on 11/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class DonationViewController: BaseProfileListViewController{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var daysField: FloatLabelTextField!
    
    @IBOutlet weak var startDate: FloatLabelTextField!
    
    @IBOutlet weak var endDate: FloatLabelTextField!
    
    
    var startDt : NSDate = NSDate()
    var endDt : NSDate = NSDate()

    
    override func viewDidLoad() {
        serverListRequestType = PersonInfoRequestType.Donations.rawValue
        tablView = tableView
        headerHeight = 50
        tableRowHeight = 50
        super.viewDidLoad()
        
        
        daysField.titleFont = UIFont.systemFontOfSize(13.0)
        startDate.titleFont = UIFont.systemFontOfSize(13.0)
        endDate.titleFont = UIFont.systemFontOfSize(13.0)
        
        daysField.delegate = self
        startDate.delegate = self
        endDate.delegate = self


        didMoveToPage((tabsMenu?.controllerArray[0])!, index: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getTabsController() -> [UIViewController] {
        var cons = super.getTabsController()
        
        let con1 = UIViewController()
        con1.title = "Last n days"
        
        let con2 = UIViewController()
        con2.title = "Interval"
        
        cons.append(con1)
        cons.append(con2)
        
        return cons
    }
    
    
    override func didMoveToPage(controller: UIViewController, index: Int) {
        var isShowDaysField = false
        if index == 0 {
            isShowDaysField = true

        }
        else {
            
        }
        daysField.superview?.hidden = isShowDaysField
        startDate.superview?.hidden = !isShowDaysField
        endDate.superview?.hidden = !isShowDaysField
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func onDateChange(){
        
    }

}


extension DonationViewController : UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == daysField {
            if let i = Int(string) where i > 0
            {
                return true;
            }
            
            return false;
        }
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField != daysField {
          
            
            var dt = textField == startDate ? startDt : endDt
            
            let popDatePicker = PopDatePicker(forTextField: textField, mode: UIDatePickerMode.Date)
            
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { [weak self] (newDate : NSDate, forTextField : UITextField) -> () in
                dt = newDate
                // here we don't use self (no retain cycle)
                forTextField.text = (TimeDateUtils.getStringFrom(newDate, mode: .Date) ?? "?") as String
                
                self?.onDateChange()
                
            }
            
            popDatePicker.pick(self, initDate: dt, dataChanged: dataChangedCallback)
         return true
        }
        
        return true
    }
}
