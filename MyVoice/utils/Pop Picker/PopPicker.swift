//
//  PopPicker.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


public class PopPicker : NSObject, UIPopoverPresentationControllerDelegate {
    
    public typealias PopPickerCallback = (newSelection : [String], forTextField : UITextField)->()
    
    var popPickerVC : PopPickerViewController
    var popover : UIPopoverPresentationController?
    var textField : UITextField!
    var dataChanged : PopPickerCallback?
    var presented = false
    var offset : CGFloat = 8.0
    
    public init(forTextField: UITextField, data: PickerInfo) {
        
        popPickerVC = PopPickerViewController()
        popPickerVC.info = data
        self.textField = forTextField
        super.init()
    }
    
    public func pick(inViewController : UIViewController, initData : [String]?, dataChanged : PopPickerCallback) {
        
        if presented {
            return  // we are busy
        }
        
        popPickerVC.delegate = self
        popPickerVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        popPickerVC.preferredContentSize = CGSizeMake(350,208)
        popPickerVC.selectRow = initData
        
        popover = popPickerVC.popoverPresentationController
        if let _popover = popover {
            
            _popover.sourceView = textField
            _popover.sourceRect = CGRectMake(self.offset,textField.bounds.size.height,0,0)
            _popover.delegate = self
            self.dataChanged = dataChanged
            inViewController.presentViewController(popPickerVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    public func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
}

extension PopPicker : PopPickerViewControllerDelegate {
    func popPickerVCDismissed(rows: [String]?) {
        if let _dataChanged = dataChanged {
            if let _data = rows {
                _dataChanged(newSelection: _data, forTextField: textField)
            }
        }
        presented = false
    }
}


