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
    static let tempUserId:Int = 6
    
    static let accentColor = UIColor(red: CGFloat(5.0/255), green: CGFloat(146.0/255), blue: CGFloat(1), alpha: 1)
    static let tab_selection = UIColor(red: CGFloat(240.0/255), green: CGFloat(90.0/255), blue: CGFloat(40.0/255), alpha: 1)
    
    static let closed_color = UIColor(red: CGFloat(0), green: CGFloat(76.0/255), blue: CGFloat(80.0/255), alpha: 1)
    
    static let grayColor_101 = UIColor(red: CGFloat(101.0/255), green: CGFloat(101.0/255), blue: CGFloat(101.0/255), alpha: 1)
    static let grayColor_131 = UIColor(red: CGFloat(131.0/255), green: CGFloat(131.0/255), blue: CGFloat(131.0/255), alpha: 1)
    static let grayColor_217 = UIColor(red: CGFloat(217.0/255), green: CGFloat(217.0/255), blue: CGFloat(217.0/255), alpha: 1)
    static let grayColor_239 = UIColor(red: CGFloat(239.0/255), green: CGFloat(239.0/255), blue: CGFloat(239.0/255), alpha: 1)

    static let addCommentViewHeight:CGFloat = 120

    
    
    static let notification_center_scroll_key = "scroll_key"
    static let notification_center_scroll_event_key = "scroll_event_key"
    
    
    static let personInfoHeader = ["BASIC_INFO".localized,"OCCUPATION_INFO".localized,"CONTACT_INFO".localized,"EDUCATION_INFO".localized]
    
    static let BriefItemUI_Follower = BriefItemUI(heading: "Followers".localized, index: "Followers", isClickable: false)
    
    static let BriefItemUI_Issue_Resolved = BriefItemUI(heading: "Issue_resolved".localized, index: "Issue", isClickable: false)
    static let BriefItemUI_Issue_Raised = BriefItemUI(heading: MyStrings.issueRaised, index: "Issue", isClickable: false)
    
    static let BriefItemUI_Badges = BriefItemUI(heading: "Badges".localized, index: "Badges", isClickable: false)
    
    static let BriefItemUI_Total_donations = BriefItemUI(heading: MyStrings.totalFunds, index: "Donation", isClickable: false)
    static let BriefItemUI_Amount_donated = BriefItemUI(heading: MyStrings.amountDonated, index: "Donation", isClickable: false)
    
    static let BriefItemUI_Credits = BriefItemUI(heading: "Credits".localized, index: "Credit", isClickable: false)
    
    static let BriefItemUI_Reviews = BriefItemUI(heading: "Reviews".localized, index: "Review", isClickable: true)
    
    
    static let BriefButtonUI_Review = BriefItemUI(heading: "Reviews".localized, index: "Review", isClickable: true)
    static let BriefButtonUI_Message = BriefItemUI(heading: "Reviews".localized, index: "Review", isClickable: true)
    static let BriefButtonUI_Donation = BriefItemUI(heading: "Reviews".localized, index: "Review", isClickable: true)
    static let BriefButtonUI_Follow = BriefItemUI(heading: "Reviews".localized, index: "Review", isClickable: true)


    
    static let residentHomeIssueFilter = [[HomeFilter(index: 0,value: MyStrings.active,dataRequest: 0),
        HomeFilter(index: 0,value: MyStrings.popular,dataRequest: 1),
        HomeFilter(index: 1,value: MyStrings.relevant,dataRequest: 2),
        HomeFilter(index: 2,value: MyStrings.subscribed,dataRequest:3),
        HomeFilter(index: 3,value: MyStrings.own,dataRequest: 5)],
       
        [HomeFilter(index: 0,value: MyStrings.active,dataRequest: 0),
            HomeFilter(index: 0,value: MyStrings.popular,dataRequest: 1),
            HomeFilter(index: 1,value: MyStrings.relevant,dataRequest: 2),
            HomeFilter(index: 2,value: MyStrings.subscribed,dataRequest: 3),
            HomeFilter(index: 3,value: MyStrings.own,dataRequest: 5)] ,
        
        [HomeFilter(index: 0,value: MyStrings.active,dataRequest: 0),
            HomeFilter(index: 1,value: MyStrings.popular,dataRequest: 1),
            HomeFilter(index: 2,value: MyStrings.relevant,dataRequest: 2),
            HomeFilter(index: 3,value: MyStrings.own,dataRequest: 5)]]
    
    
    static let leaderHomeIssueFilter = [[HomeFilter(index: 0,value: MyStrings.active,dataRequest: 0),
        HomeFilter(index: 0,value: MyStrings.popular,dataRequest: 1),
        HomeFilter(index: 1,value: MyStrings.relevant,dataRequest: 2),
        HomeFilter(index: 2,value: MyStrings.subscribed,dataRequest: 3),
        HomeFilter(index: 3,value: MyStrings.resolved,dataRequest: 4),
        HomeFilter(index: 4,value: MyStrings.own,dataRequest: 5)],
      
        [HomeFilter(index: 0,value: MyStrings.active,dataRequest: 0),
            HomeFilter(index: 0,value: MyStrings.popular,dataRequest: 1),
            HomeFilter(index: 1,value: MyStrings.relevant,dataRequest: 2),
            HomeFilter(index: 2,value: MyStrings.subscribed,dataRequest: 3),
            HomeFilter(index: 3,value: MyStrings.resolved,dataRequest: 4),
            HomeFilter(index: 4,value: MyStrings.own,dataRequest: 5)] ,
        
        [HomeFilter(index: 0,value: MyStrings.active,dataRequest: 1),
            HomeFilter(index: 1,value: MyStrings.popular,dataRequest: 1),
            HomeFilter(index: 2,value: MyStrings.relevant,dataRequest: 1),
            HomeFilter(index: 3,value: MyStrings.own,dataRequest: 1)]]
    
    
    static func getChartColor(val : Double) -> UIColor {
        switch (val) {
        case let x where x > 80.0:
           return UIColor(colorLiteralRed: (37/255.0), green: (187/255.0), blue: (28/255.0), alpha: 1)
        case let x where x > 60.0:
            return UIColor(colorLiteralRed: (40/255.0), green: (213/255.0), blue: (9/255.0), alpha: 1)
        case let x where x > 40.0:
            return UIColor(colorLiteralRed: (97/255.0), green: (240/255.0), blue: (9/255.0), alpha: 1)
        case let x where x > 20.0:
            return UIColor(colorLiteralRed: (147/255.0), green: (246/255.0), blue: (9/255.0), alpha: 1)
        case let x where x > 0.0:
            return UIColor(colorLiteralRed: (243/255.0), green: (239/255.0), blue: (11/255.0), alpha: 1)
        case let x where x > -20.0:
            return UIColor(colorLiteralRed: (243/255.0), green: (239/255.0), blue: (11/255.0), alpha: 1)
        case let x where x > -40.0:
            return UIColor(colorLiteralRed: (226/255.0), green: (104/255.0), blue: (6/255.0), alpha: 1)
        case let x where x > -60.0:
            return UIColor(colorLiteralRed: (234/255.0), green: (60/255.0), blue: (8/255.0), alpha: 1)
        case let x where x > -80.0:
            return UIColor(colorLiteralRed: (237/255.0), green: (0/255.0), blue: (7/255.0), alpha: 1)
        default:
            return UIColor(colorLiteralRed: (228/255.0), green: (0/255.0), blue: (8/255.0), alpha: 1)
        }
    }
    
    
    static var reviewFilters : [BaseFilter] = [BaseFilter(index: 0, value: MyStrings.extremelyPositive, dataRequest:0),
        BaseFilter(index: 1, value: MyStrings.positive, dataRequest:1),
        BaseFilter(index: 2, value: MyStrings.neutral, dataRequest:2),
        BaseFilter(index: 3, value: MyStrings.negative, dataRequest:3),
        BaseFilter(index: 4, value: MyStrings.extreamlyNegative, dataRequest:4)]
    
}

class PermanentDataKey {
    static let isLoginDone = "isLoginDone"
    static let userId = "userId"
    
}


enum PersonBasicInfoType:Int{
    case Basic = 0, Occupation, Contact, Education
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

struct IntString {
    var int :Int!
    var string :String!
    
    init(int:Int, str2:String){
        self.int = int
        string = str2
    }
}


struct UIScrollViewWithEvent {
    var scrollView:UIScrollView!
    
}


class TextFieldWithCharacterLimit {
    var field : UITextField!
    var minLimit = 10
    var maxLimit = 5000
    init (field : UITextField , minLimit : Int = 10, maxLimit:Int = 5000){
        self.minLimit = minLimit
        self.maxLimit = maxLimit
        self.field = field
    }
    
    
    static func isFieldInArray (field : UITextField , list : [TextFieldWithCharacterLimit]) -> TextFieldWithCharacterLimit?{
        
        for f in list {
            if f.field == field {
                return f
            }
        }
        
        return nil
    }
}

enum Actions :Int {
    case  Subscribe = 48, Share = 49, Comment = 50, Flag = 51, Message = 52, VoteUp = 10, VoteDown = 11
}

protocol ActionsDelegate : class { 
    func onActionButtonClick( action: Actions);
}