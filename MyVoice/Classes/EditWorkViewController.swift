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
    //  @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: DescriptionView!
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var category: FloatLabelTextField!
    
    override func viewDidLoad() {
        mainTitle = "Work".localized
        
        super.viewDidLoad()
        
        // popDatePickerTextFields.append(PopDatePickerParam(field: dateField, mode: UIDatePickerMode.DateAndTime))
        collection = imagesCollection
        // Do any additional setup after loading the view.
        //shadowObject.append(descriptionField)
        
        addItemUrl = ServerUrls.addWorkUrl
        updateItemUrl = ServerUrls.updateWorkUrl
        
        
        // category
        var info = PopInfo()
        info.items = [[String]]()
        info.items?.append([String]())
        info.heading = MyStrings.categories
        // removing all option
        var enty = CurrentSession.i.appDataManager.appData.categories
        if enty.count > 0 {
            enty.removeFirst()
        }
        info.items![0].appendContentsOf(enty)
        
        addTextFieldForPickerPopOver(category, info: info)

        
    }
    
    override func getDataForNewItem() -> BaseData {
        return MyWorkData()
    }
    
    override func initialiseViews() {
        super.initialiseViews()
        if let d = data as? MyWorkData {
            titleField.text = d.title
            descriptionField.text = d.description
            //dateField.text =  d.disPlayDate
            category.text = d.category

        }
    }
    
    override func fetchDataFromUIElements() {
        super.fetchDataFromUIElements()
        if let d = data as? MyWorkData {
            d.title = titleField.text ?? ""
            d.description = descriptionField.text ?? ""
            //  d.disPlayDate = dateField.text ?? ""
            d.category = category.text ?? ""

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





