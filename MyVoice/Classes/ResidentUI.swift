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
        
    }
    
    override func personSpecificParmeter() {
        donationType = DonationType.donated
        nHomeTabs = 3
        briefType = .Resident
        profileTabs = [TwoString(str1: "BasicInfo", str2: "Info"),
            TwoString(str1: "ActivityViewController", str2: "Activity"),
            TwoString(str1: "EventViewController", str2: "Events")]

    }
    
    override func getTextFieldDataBy(index: Int)->[TextFieldInputData]?{
        
        switch (index){
        case 0:
            return basicTextFieldInfo()
        case 1:
            return occupationTextFieldInfo()
        case 2:
            return contactTextFieldInfo()
        case 3:
            return educationTextFieldInfo()

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
        
        
        let fMarriage = getTextFieldInputDataForPickerData(["SINGLE".localized,"MARRIED".localized,"OTHERS".localized])
        
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