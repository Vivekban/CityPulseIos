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
        breifViewCollectionRect = CGRectMake(420, 10, 584, 80)
        briefViewItems = [Constants.BriefItemUI_Follower,Constants.BriefItemUI_Issue_Resolved,Constants.BriefItemUI_Badges,Constants.BriefItemUI_Total_donations,Constants.BriefItemUI_Credits,Constants.BriefItemUI_Reviews]
    }
    
    override func basicTextFieldInfo()->[TextFieldInputData]{
        var fields =  super.basicTextFieldInfo()
        var fParty = getTextFieldInputDataForPickerData([String]())
        fParty.isDataFetched = false
        
        fields  += [fParty]
        
        return fields
        
    }
}