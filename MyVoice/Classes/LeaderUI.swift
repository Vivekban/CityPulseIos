//
//  Leader.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class LeaderUI: ResidentUI {
    
    override init() {
        super.init()
        basicInfoItems += ["PoliticalParty"]
        nHomeTabs = 5
        //TwoString(str1: "MyWorkViewController", str2: "Videos")
    }
    
    override func personSpecificParmeter() {
        briefType = BriefProfilePersonType.Leadear
         homeFilters = Constants.leaderHomeIssueFilter
        profileTabs.appendContentsOf([TwoString(str1: "MyWorkViewController", str2: "Work"),TwoString(str1: "MyViews", str2: "Views"),TwoString(str1: "EventViewController", str2: "Events"),TwoString(str1: "AnalyticsViewController", str2: "Analytics"),TwoString(str1: "BasicInfo", str2: "Info")])

    }
    
    override func basicTextFieldInfo()->[TextFieldInputData]{
        var fields =  super.basicTextFieldInfo()
        var fParty = getTextFieldInputDataForPickerData([String]())
        fParty.isDataFetched = false
        
        fields  += [fParty]
        
        return fields
        
    }
}