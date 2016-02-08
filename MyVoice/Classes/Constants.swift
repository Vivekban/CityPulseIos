//
//  Constants.swift
//  MyVoice
//
//  Created by PB014 on 24/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import ObjectMapper


class Constants {
    
    static let isDebug = true
    static let tempUserId:Int = 1
    
    static let accentColor = UIColor(red: CGFloat(5.0/255), green: CGFloat(146.0/255), blue: CGFloat(1), alpha: 1)

    static let notification_center_scroll_key = "scroll_key"
    static let notification_center_scroll_event_key = "scroll_event_key"

    
    static let personInfoHeader = ["BASIC_INFO".localized,"CONTACT_INFO".localized,"EDUCATION_INFO".localized,"OCCUPATION_INFO".localized]
    
    static let BriefItemUI_Follower = BriefItemUI(heading: "Follower".localized, index: "Followers", isClickable: false)
   
    static let BriefItemUI_Issue_Resolved = BriefItemUI(heading: "Issue_resolved".localized, index: "Issue", isClickable: false)
    static let BriefItemUI_Issue_Raised = BriefItemUI(heading: MyStrings.issueRaised, index: "Issue", isClickable: false)
    
    static let BriefItemUI_Badges = BriefItemUI(heading: "Badges".localized, index: "Badges", isClickable: false)
    
    static let BriefItemUI_Total_donations = BriefItemUI(heading: "Total_donations".localized, index: "Donation", isClickable: false)
    static let BriefItemUI_Amount_donated = BriefItemUI(heading: MyStrings.amountDonated, index: "Donation", isClickable: false)

    static let BriefItemUI_Credits = BriefItemUI(heading: "Credits".localized, index: "Credit", isClickable: false)
   
    static let BriefItemUI_Reviews = BriefItemUI(heading: "Reviews".localized, index: "Review", isClickable: true)
  
}

class PermanentDataKey {
    static let isLoginDone = "isLoginDone"
    static let userId = "userId"

}

enum IssuesConrollerType : Int {
    case Own = 0, Popular, Relevant, Subscribed, Resolved
}

enum PersonInfoType:Int{
    case Basic = 0, Contact, Education, Occupation
}


class MyColor {
    // Colors
    static let grey_131 = UIColor(red: CGFloat(131.0/255), green: CGFloat(131.0/255), blue: CGFloat(131.0/255), alpha: 1)
}


struct BriefItemUI {
    var heading = ""
    var isClickable = false
    var iconName = "Badges"
    
    init (heading: String , index:String, isClickable: Bool){
        self.heading = heading
        self.iconName = index
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


struct Location {
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var city:String = ""
}

/**
*   For header and content info UITable or UiCollection view
*/

protocol ListHeaderDelegate : class{
    func onHeaderClick(index : Int)
    func onEditButtonclick(index : Int)
    func onDetailClick(index: Int)
}

/**
 * UITable cell or CollectionView  content delegate
*/

protocol LisContentDelegate{
}

struct TwoString {
    var string_1 :String!
    var string_2 :String!
    
    init(str1:String, str2:String){
        string_1 = str1
        string_2 = str2
    }
}

struct UIScrollViewWithEvent {
    var scrollView:UIScrollView!
     
}





