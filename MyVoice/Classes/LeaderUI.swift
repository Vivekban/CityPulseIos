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
        basicInfoItems += ["Political Party"]
        nHomeTabs = 5
        //TwoString(str1: "MyWorkViewController", str2: "Videos")
    }
    
    override func personSpecificParmeter() {
        donationType = DonationType.received
        
        briefType = BriefProfileType.TopBarResident
        homeFilters = Constants.leaderHomeIssueFilter
        
        profileTabs.appendContentsOf([TwoString(str1: "MyWorkViewController", str2: MyStrings.works),
            TwoString(str1: "MyViews", str2: MyStrings.views),
            TwoString(str1: "EventViewController", str2: MyStrings.events),
            TwoString(str1: "ActivityViewController", str2: MyStrings.activity),
            TwoString(str1: "AnalyticsViewController", str2: MyStrings.analytics),
            TwoString(str1: "BasicInfo", str2: MyStrings.video),
            TwoString(str1: "BasicInfo", str2: MyStrings.info)])
        
        
        secondPersonProfileTabs.appendContentsOf([(identifier:"MyWorkViewController",title:MyStrings.works,storyBoard:"Me"),
            (identifier:"MyViews",title:MyStrings.views,storyBoard:"Me"),
            (identifier:"EventViewController",title:MyStrings.events,storyBoard:"Me"),
            (identifier:"IssueViewController",title:MyStrings.activeIssues,storyBoard:"Home"),
            (identifier:"IssueViewController",title:MyStrings.resolvedIssues,storyBoard:"Home")
            ])
    }
    
    override func basicTextFieldInfo()->[TextFieldInputData]{
        var fields =  super.basicTextFieldInfo()
        var fParty = getTextFieldInputDataForPickerData([String]())
        fParty.isDataFetched = false
        
        fields  += [fParty]
        
        return fields
        
    }
}