//
//  Resident.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class ResidentUI: PersonUI {
    
    override init() {
        super.init()
        basicInfoItems += ["Full Name","Martial Status", "Date of Birth", "City you care for","Gender", "Issues you care for"]
        contactInfoItems += ["Address","Facebook","City","Twitter Handle", "Zip", "LinkedIn","Phone","Email"]
        nHomeTabs = 3
        
        breifViewCollectionRect = CGRectMake(750, 10, 240, 80)
        briefViewItems = [Constants.BriefItemUI_Credits,Constants.BriefItemUI_Badges,Constants.BriefItemUI_Total_donations]
        
        
    }
    
    override func getTextFieldDataBy(index: Int)->[TextFieldInputData]?{
        
        switch (index){
        case 0:
            return basicTextFieldInfo()
        case 1:
            return contactTextFieldInfo()
        case 2:
            return educationTextFieldInfo()
        case 3:
            return occupationTextFieldInfo()
        default:
            assertionFailure()
        }
        return basicTextFieldInfo()
        
    }
    
    func basicTextFieldInfo()->[TextFieldInputData]{
        
        var fields = [TextFieldInputData]()
        
        let fText = TextFieldInputData()
        var fDate = TextFieldInputData()
        fDate.inputType = .DATE_PICKER
        
        
        let fMarriage = getTextFieldInputDataForPickerData(["SINGLE".localized,"MARRIED".localized])
        
        let fGender = getTextFieldInputDataForPickerData(["MALE".localized,"FEMALE".localized,"OTHERS".localized])
        
        var fIssue = getTextFieldInputDataForPickerData([String]())
        fIssue.isDataFetched = false
        
        
        
        fields  += [fText,fMarriage,fDate,fText,fGender,fIssue]
        return fields
        
    }
    
     func contactTextFieldInfo()->[TextFieldInputData]{
        var fields = [TextFieldInputData]()
        
        let fText = TextFieldInputData()
       
        var fNumber = TextFieldInputData()
        fNumber.keyboardType = .NumberPad
        
        var fPhone = TextFieldInputData()
        fPhone.keyboardType = .PhonePad
        
        var fEmail = TextFieldInputData()
        fEmail.keyboardType = .EmailAddress

        var fDate = TextFieldInputData()
        fDate.inputType = .DATE_PICKER
        
        fields  += [fText,fText,fText,fText,fNumber,fText,fPhone,fEmail]

        return fields
        
    }
    
    func educationTextFieldInfo()->[TextFieldInputData]{
        var fields = [TextFieldInputData]()
        
        let fText = TextFieldInputData()
        
        var fNumber = TextFieldInputData()
        fNumber.keyboardType = .NumberPad
        
        fields  += [fText,fNumber]
        
        return fields
        
    }
    func occupationTextFieldInfo()->[TextFieldInputData]{
        var fields = [TextFieldInputData]()
        
        let fText = TextFieldInputData()
        var fDate = TextFieldInputData()
        fDate.inputType = .DATE_PICKER
        
        fields  += [fText,fText,fDate,fDate]
        
        return fields
        
    }
    
    
    func getTextFieldInputDataForPickerData(arrays: [String]) -> TextFieldInputData{
        var f = TextFieldInputData()
        f.inputType = .PICKER
        f.isDataFetched = true
        f.pickerData.appendContentsOf(arrays)
        return f;
    }
    
}