//
//  DataPicker.swift
//  iDoctors
//
//  Created by Valerio Ferrucci on 30/09/14.
//  Copyright (c) 2014 Tabasoft. All rights reserved.
//

import UIKit

public class PopDatePicker : NSObject, UIPopoverPresentationControllerDelegate, DataPickerViewControllerDelegate {
    
    public typealias PopDatePickerCallback = (newDate : NSDate, forTextField : UITextField)->()
    
    var datePickerVC : PopDateViewController
    var popover : UIPopoverPresentationController?
    var textField : UITextField!
    var dataChanged : PopDatePickerCallback?
    var presented = false
    var offset : CGFloat = 8.0
    var mode:UIDatePickerMode = .Date
    
    public init(forTextField: UITextField, mode:UIDatePickerMode) {
        
        datePickerVC = PopDateViewController()
        self.textField = forTextField
        self.mode = mode
        super.init()
    }
    
    public func pick(inViewController : UIViewController, initDate : NSDate?, dataChanged : PopDatePickerCallback) {
        
        if presented {
            return  // we are busy
        }
        
        datePickerVC.delegate = self
        datePickerVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        datePickerVC.datePickerMode = mode
        
        datePickerVC.preferredContentSize = CGSizeMake(getPickerWidth(),208)
        datePickerVC.currentDate = initDate
        
        popover = datePickerVC.popoverPresentationController
        if let _popover = popover {
            
            _popover.sourceView = textField
            _popover.sourceRect = CGRectMake(self.offset,textField.bounds.size.height,0,0)
            _popover.delegate = self
            self.dataChanged = dataChanged
            inViewController.presentViewController(datePickerVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    func getPickerWidth() ->CGFloat {
        switch mode {
        case .Date:
             return 420
        case .DateAndTime :
            return 460
        case .Time:
            return 280
        case .CountDownTimer:
            return 360
        }
        
    }
    
    public func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    func datePickerVCDismissed(date : NSDate?) {
        
        if let _dataChanged = dataChanged {
            
            if let _date = date {
            
                _dataChanged(newDate: _date, forTextField: textField)
        
            }
        }
        presented = false
    }
}

struct PopDatePickerParam :Equatable{
    var textField:UITextField!
    var mode:UIDatePickerMode = .Date
    
    init(field:UITextField, mode:UIDatePickerMode){
        self.mode = mode
        self.textField = field
    }
    
}

func ==(lhs: PopDatePickerParam, rhs: PopDatePickerParam) -> Bool {
    return lhs.textField == rhs.textField
}