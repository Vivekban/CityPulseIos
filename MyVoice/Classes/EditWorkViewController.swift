//
//  EditWorkViewController.swift
//  MyVoice
//
//  Created by PB014 on 07/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EditWorkViewController: BaseImageEditViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var imagesCollection: UICollectionView!
    
    override func viewDidLoad() {
        mainTitle = "Work".localized
        super.viewDidLoad()
        popDatePickerTextFields.append(PopDatePickerParam(field: dateField, mode: UIDatePickerMode.DateAndTime))
        collection = imagesCollection
        // Do any additional setup after loading the view.
        shadowObject.append(descriptionField)
    }
    
    override func initialiseViews() {
        super.initialiseViews()
        if let d = data as? MyWorkData {
            titleField.text = d.title
            descriptionField.text = d.description
            dateField.text =  d.date.isEmpty ? MyUtils.getShortDateInString(NSDate()): d.date
        }
    }
    
    override func fetchDataFromUIElements() {
        if let d = data as? MyWorkData {
            d.title = titleField.text ?? ""
            d.description = descriptionField.text ?? ""
            d.date = dateField.text ?? ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





