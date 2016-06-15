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
    var infoType:PersonBasicInfoType = .Basic {
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
        if let d = data as? PersonBasicData {
            for i in 0..<allTextFields.count {
                d.setValueBy(infoType, row: i, value: allTextFields[i].text ?? "")
            }
        }
    }
    
    override func isDataReadyToSave() -> String? {
        switch (infoType) {
        case .Basic:
            return super.isDataReadyToSave()
        default:
            return ""
        }
    }
    
    
    override func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                //self.animateTextField(true)
                
                if  scrollView != nil{
                    
                    let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight, 0.0);
                    scrollView!.contentInset = contentInsets;
                    scrollView!.scrollIndicatorInsets = contentInsets;
                    
                    
                    if activeTextField != nil {
                        // If active text field is hidden by keyboard, scroll it so it's visible
                        // Your app might not need or want this behavior.
                        var aRect = self.view.frame;
                        aRect.size.height -= kbHeight;
                        
                        var frame = MyUtils.getViewPositionWithRespectToView(activeTextField!, baseView: scrollView)
                        if (!CGRectContainsPoint(aRect, frame.origin ) ) {
                            frame.origin.y = (frame.origin.y) + 10
                            scrollView?.scrollRectToVisible((frame), animated: true)
                        }
                    }
                }
            }
        }
    }//
    
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
        cell.textField.delegate = self
        
        if let tFData = textFieldsDatas?[indexPath.row] {
            
            switch (tFData.inputType){
            case .DATE_PICKER:
                addTextFieldForDatePopOver(PopDatePickerParam(field: cell.textField, mode: .Date))
                break
            case .PICKER:
                var info = PopInfo()
                info.items = [[String]]()
                info.items?.append(tFData.pickerData)
                addTextFieldForPickerPopOver(cell.textField, info: info)
                break
            case .NORMAL:
                cell.textField.keyboardType = tFData.keyboardType
                break
            }
            
        }
        
        cell.textField.text = CurrentSession.i.personController.person.basicInfo.getValueBy(infoType, row: indexPath.row) ?? ""
        
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
