//
//  Constants.swift
//  MyVoice
//
//  Created by PB014 on 24/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit


class Constants {
    static let personInfoHeader = ["BASIC_INFO".localized,"CONTACT_INFO".localized,"EDUCATION_INFO".localized,"OCCUPATION_INFO".localized]
    static let accentColor = UIColor(red: CGFloat(5.0/255), green: CGFloat(146.0/255), blue: CGFloat(1), alpha: 1)
    
    static let BriefItemUI_Follower = BriefItemUI(heading: "Follower".localized, index: 0, isClickable: false)
    static let BriefItemUI_Issue_Resolved = BriefItemUI(heading: "Issue_resolved".localized, index: 1, isClickable: false)
    static let BriefItemUI_Badges = BriefItemUI(heading: "Badges".localized, index: 2, isClickable: false)
    static let BriefItemUI_Total_donations = BriefItemUI(heading: "Total_donations".localized, index: 3, isClickable: false)
    static let BriefItemUI_Credits = BriefItemUI(heading: "Credits".localized, index: 4, isClickable: false)
    static let BriefItemUI_Reviews = BriefItemUI(heading: "Reviews".localized, index: 5, isClickable: true)
  
    
}

enum IssuesConrollerType : Int {
    case Own = 0, Popular, Relevant, Subscribed, Resolved
}


class MyColor {
    // Colors
    static let grey_131 = UIColor(red: CGFloat(131.0/255), green: CGFloat(131.0/255), blue: CGFloat(131.0/255), alpha: 1)
}


struct BriefItemUI {
    var heading = ""
    var index = 0
    var isClickable = false
    
    init (heading: String , index:Int, isClickable: Bool){
        self.heading = heading
        self.index = index
        self.isClickable = isClickable
    }
}


enum TextFieldInputType:Int{
    case NORMAL = 1, DATE_PICKER, PICKER
}

struct TextFieldInputData {
    var inputType:TextFieldInputType = .NORMAL
    var keyboardType:UIKeyboardType = .Default
    var pickerData = [String]()
    // in case of online picker fields
    var isDataFetched = false
}


