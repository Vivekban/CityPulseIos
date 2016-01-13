//
//  BaseEditViewController.swift
//  MyVoice
//
//  Created by PB014 on 11/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class BaseEditViewController: UIViewController {
    
    enum Type : Int {
        case NEW = 1,EDIT
    }
    
    var data:AnyObject?
    var type:Type = .EDIT
    var mainTitle:String = ""
    var myNavigationItem: UINavigationItem?
    
    // pickers for date
    var popDatePickers = [PopDatePicker]()
    var popDatePickerTextFields = [UITextField]()
    
    // string pickers
    var popPickers = [PopPicker]()
    var popPickerTextFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNavigationItem = (self.view.viewWithTag(1) as? UINavigationBar)?.items![0]
        addTargetsTo(myNavigationItem?.rightBarButtonItems![0], and:myNavigationItem?.leftBarButtonItems![0])
        
        
        
//        let btnName = UIButton()
//        btnName.setImage(UIImage(named: "imagename"), forState: .Normal)
//        btnName.frame = CGRectMake(0, 0, 30, 30)
//        btnName.addTarget(self, action: Selector("action"), forControlEvents: .TouchUpInside)
//        
//        //.... Set Right/Left Bar Button item
//        let rightBarButton = UIBarButtonItem()
//        rightBarButton.customView = btnName
//        self.navigationItem.rightBarButtonItem = rightBarButton
//        For System UIBarButtonItem
//        
//        let camera = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: Selector("btnOpenCamera"))
//        self.navigationItem.rightBarButtonItem = camera
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initialiseViews()
    }
    
    func initialiseViews(){
        switch (type){
            
        case .NEW:
            self.navigationItem.title = "Add " + mainTitle
            break
        case .EDIT:
            self.navigationItem.title = "Edit " + mainTitle
            break
        }
        
        for texField in popDatePickerTextFields {
            let popDatePicker = PopDatePicker(forTextField: texField)
            popDatePickers.append(popDatePicker)
            texField.delegate = self
        }
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addTextFieldForDatePopOver(field :UITextField){
        if !popDatePickerTextFields.contains(field){
        
        popDatePickerTextFields.append(field)
        let popDatePicker = PopDatePicker(forTextField: field)
        popDatePickers.append(popDatePicker)
        field.delegate = self
        }
    }
    
    func addTextFieldForPickerPopOver(field :UITextField, info: PickerInfo){
        if !popPickerTextFields.contains(field){
            
            popPickerTextFields.append(field)
            let popPicker = PopPicker(forTextField: field, data: info)
            popPickers.append(popPicker)
            field.delegate = self
        }
    }
    
    
    func setDataSourceWith(type:Type, and data :AnyObject?){
        self.type = type
        self.data = data
    }
    
    
    
    
    func addTargetsTo(saveButton: AnyObject?, and cancelButton: AnyObject?){
        if let barSave = saveButton as?  UIBarButtonItem {
            barSave.target = self
            barSave.action = Selector("onSaveButtonClick")
        }
        if let barCancel = cancelButton as?  UIBarButtonItem {
            barCancel.target = self
            barCancel.action = Selector("onCancelButtonClick")
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    
    
    // MARK: Actions
    
    func onCancelButtonClick() {
       // self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onSaveButtonClick() {
        saveDetails()
        onCancelButtonClick()
    }
    
    func saveDetails(){
        preconditionFailure("This method must be overridden")
    }
    
    func resign(){
        dismissKeyboard()
//        for textField in popDatePickerTextFields {
//            textField.resignFirstResponder()
//        }
//        for textField in popPickerTextFields {
//            textField.resignFirstResponder()
//        }
//        view.endEditing(true)
    }
    
}


extension BaseEditViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if popDatePickerTextFields.contains(textField) {
            resign()
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let initDate : NSDate? = formatter.dateFromString(textField.text!)
            
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
                
                // here we don't use self (no retain cycle)
                forTextField.text = (MyUtils.getShortDateInString(newDate) ?? "?") as String
                
            }
            
            popDatePickers[popDatePickerTextFields.indexOf(textField)!].pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
        }
        else if (popPickerTextFields.contains(textField)){
            resign()
            popPickers[popPickerTextFields.indexOf(textField)!].pick(self, initData: [textField.text ?? ""], dataChanged: { (newSelection, forTextField) -> () in
                forTextField.text = newSelection[0]
            })
            return false
        }
        return true
    }
}
