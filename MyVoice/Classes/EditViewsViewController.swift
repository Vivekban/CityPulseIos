//
//  EditViewsViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class EditViewsViewController: BaseEditViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        mainTitle = "View".localized
        super.viewDidLoad()
        popDatePickerTextFields.append(dateField)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        MyUtils.createShadowOnView(descriptionField)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initialiseViews() {
        super.initialiseViews()
        if let d = data as? MyViews {
            titleField.text = d.title
            descriptionField.text = d.description
            dateField.text = MyUtils.getShortDateInString(NSDate())
        }
        
    }
    
    
    //MARK: Actions
    
    @IBAction func dateFieldEditingBegin(sender: UITextField) {
        let datePicker = MyUtils.getDatePicker(self, selector: Selector("datePickerValueChanged:"))
        datePicker.setDate(NSDate(), animated: false)
        sender.inputView = datePicker
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateField.text = dateFormatter.stringFromDate(sender.date)
        
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
