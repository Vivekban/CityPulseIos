//
//  PopPickerViewController.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol PopPickerViewControllerDelegate : class {
    
    func popPickerVCDismissed(rows : [String]?)
}

public struct PickerInfo {
    var items:[[String]]?
}

class PopPickerViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
   
    weak var delegate : PopPickerViewControllerDelegate?
    
    var info:PickerInfo?
    
    var selectRow : [String]? {
        didSet {
            updatePickerCurrentValue()
        }
    }
    
    convenience init() {
        
        self.init(nibName: "PopPickerViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        updatePickerCurrentValue()

    }
    override func viewDidDisappear(animated: Bool) {
        
        self.delegate?.popPickerVCDismissed(nil)
    }
    
    private func updatePickerCurrentValue() {
        if let _currentDate = self.selectRow {
            if (self.pickerView != nil) {
                for (i, text) in _currentDate.enumerate(){
                    
                self.pickerView.selectRow(foundOutItem(i, value: text), inComponent: i, animated: true)
                }
            }
        }
    }
    
    func foundOutItem(index: Int, value :String) ->Int {
       if value == "" {
            return 0
        }
        else{
            return info?.items![index].indexOf(value) ?? 0
        }
    }

    
    @IBAction func onOkButtonClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true) {
            var rows = [String]()
            for (i,item) in (self.info?.items?.enumerate())!  {
                let j = self.pickerView.selectedRowInComponent(i)
                if (item.count > j){
                 rows.append(item[j])
                }
            }
            self.delegate?.popPickerVCDismissed(rows.count > 0 ? rows : nil)
        }
    }
    
}


extension PopPickerViewController : UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return (info?.items?.count)!
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (info?.items![component].count)!
    }

}

extension PopPickerViewController : UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (info?.items![component][row])!

    }
}
