//
//  PopPicker.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


public class PopTable : NSObject, UIPopoverPresentationControllerDelegate {
    
    
    var popVC : PopTableViewController
    var popover : UIPopoverPresentationController?
    var textField : UIView!
    var dataChanged : PopCallback?
    var presented = false
    var offset : CGFloat = 8.0
    
    public init(forTextField: UIView, data: PopInfo) {
        
        popVC = PopTableViewController()
        popVC.info = data
        self.textField = forTextField
        super.init()
    }
    
    
    func updateData(index: Int , newData:[String]){
        var items = popVC.info?.items
        if index < items?.count {
            items![index].removeAll()
            items?[index].appendContentsOf(newData)
        }
        popVC.info?.items = items
        if (popVC.tableView != nil){
            popVC.tableView.reloadData()
        }
        
    }
    
    func updateHeading(newData:String){
            popVC.info?.heading = newData
    }
    
    
    public func pick(inViewController : UIViewController, initData : [String]?, dataChanged : PopCallback) {
        
        if presented {
            return  // we are busy
        }
        
        popVC.delegate = self
        popVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        // popPickerVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
        
        // popPickerVC.tableView.reloadData()
        popVC.preferredContentSize = CGSizeMake(calculateWidth(), CGFloat (min(max(5,(popVC.info?.items![0].count)!),10) * 44 - 2))

        
        
        popVC.selectRow = initData
        
        popover = popVC.popoverPresentationController
        if let _popover = popover {
            
            // _popover.sourceView = textField
            // _popover.sourceRect = CGRectMake(self.offset,textField.bounds.size.height,0,0)
            _popover.permittedArrowDirections = UIPopoverArrowDirection.Up
            _popover.sourceView = textField
            _popover.sourceRect = textField.bounds
            
            
            let label = UILabel()
            label.font = UIFont.systemFontOfSize(18)
            label.text = popVC.info?.heading
            label.sizeToFit()
            
            if (textField.bounds.size.width) > 30 + label.frame.width {
                _popover.sourceRect.size.width = label.frame.size.width
 
            }
            
            _popover.delegate = self
            _popover.backgroundColor = UIColor.whiteColor()
            self.dataChanged = dataChanged
            inViewController.presentViewController(popVC, animated: true, completion: nil)
            presented = true
        }
    }
    
    func calculateWidth() -> CGFloat {
       
      var maxStringSize = popVC.info?.heading.characters.count ?? 0
        if let items = popVC.info?.items![0] {
            for item in items {
                if item.characters.count > maxStringSize {
                    maxStringSize = item.characters.count
                }
            }
        }
        return CGFloat(40 + maxStringSize * 9)
    }

    
    public func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
}


extension PopTable : PopViewControllerDelegate {
    func popVCDismissed(rows: [String]?) {
        if let _dataChanged = dataChanged {
            if let _data = rows {
                _dataChanged(newSelection: _data, forTextField: textField)
            }
        }
        presented = false
    }
}


