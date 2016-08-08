//
//  PopPicker.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

public typealias PopCallback = (newSelection : [String]?, forTextField : UIView)->()


public class PopPicker : NSObject, UIPopoverPresentationControllerDelegate {
    
    
    var popPickerVC : PopPickerViewController
    var popover : UIPopoverPresentationController?
    var textField : UITextField!
    var dataChanged : PopCallback?
    var presented = false
    var offset : CGFloat = 8.0
    
    public init(forTextField: UITextField, data: PopInfo) {
        
        popPickerVC = PopPickerViewController()
        popPickerVC.info = data
        self.textField = forTextField
        super.init()
    }
    
    func updateData(index: Int , newData:[String]){
        var items = popPickerVC.info?.items
        if index < items?.count {
            items![index].removeAll()
            items?[index].appendContentsOf(newData)
        }
        popPickerVC.info?.items = items
    }
    
    public func pick(inViewController : UIViewController, initData : [String]?, dataChanged : PopCallback) {
        
        if presented {
            return  // we are busy
        }
        
        popPickerVC.delegate = self
        popPickerVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        popPickerVC.preferredContentSize = CGSizeMake(260,208)
        popPickerVC.selectRow = initData
        
        popover = popPickerVC.popoverPresentationController
        if let _popover = popover {
            
            _popover.sourceView = textField
            _popover.sourceRect = textField.bounds
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

extension PopPicker : PopViewControllerDelegate {
    func popVCDismissed(rows: [String]?) {
        if let _dataChanged = dataChanged {
            if let _data = rows {
                _dataChanged(newSelection: _data, forTextField: textField)
            }
            _dataChanged(newSelection: nil, forTextField: textField)

        }
        presented = false
    }
}


