//
//  EditBasicInfoViewController.swift
//  MyVoice
//
//  Created by PB014 on 12/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EditBasicInfoViewController: BaseEditViewController {
    var columns = 2
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let reuseIdentifier = "EditInfoCell"
    
    var items:[String]?
    var allTextFields = [UITextField]()
    var textFieldsDatas:[TextFieldInputData]?
    var infoType:PersonInfoType = .Basic {
        didSet{
            items = CurrentSession.i.personUI?.getInfoItemBy(infoType)
            textFieldsDatas  = CurrentSession.i.personUI?.getTextFieldDataBy(infoType.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateItemUrl = ServerUrls.updateUserDetailsUrl
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
    }
   
    
//    override func saveDetails() {
//        
//    }
    
    override func fetchDataFromUIElements() {
        let data = CurrentSession.i.personController.person.basicInfo
        
        for i in 0..<allTextFields.count {
            data.setValueBy(infoType, row: i, value: allTextFields[i].text ?? "")
        }
    }

}


extension EditBasicInfoViewController : UICollectionViewDataSource {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (items?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! EditInfoCell
        
        cell.textField.placeholder = items![indexPath.row]
        
        if let tFData = textFieldsDatas?[indexPath.row] {
            
            switch (tFData.inputType){
            case .DATE_PICKER:
                addTextFieldForDatePopOver(PopDatePickerParam(field: cell.textField, mode: .Date))
                break
            case .PICKER:
                var info = PickerInfo()
                info.items = [[String]]()
                info.items?.append(tFData.pickerData)
                addTextFieldForPickerPopOver(cell.textField, info: info)
                break
            case .NORMAL:
                cell.textField.keyboardType = tFData.keyboardType
                break
            }
            
        }
        if let infoType = PersonInfoType(rawValue: indexPath.section) {
            cell.textField.text = CurrentSession.i.personController.person.basicInfo.getValueBy(infoType, row: indexPath.row) ?? ""
        }
        allTextFields.append(cell.textField)
        // indexPath.section
        // indexPath.row
        // Configure the cell
        
        return cell
    }
    
}

extension EditBasicInfoViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        
        return CGSize(width: Int(collectionView.frame.size.width)/columns - 30, height: 80)
    }
    
}
