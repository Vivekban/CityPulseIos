//
//  PersonUI.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

/// Base model class for PersonUI cantain blueprint of PersonUI

enum DonationType : Int {
    case donated = 0,received
    
    func  toString() -> String {
        switch self {
        case .donated:
            return MyStrings.donationMade
        case .received:
            return MyStrings.donationReceived
        }
    }
}

class PersonUI {
    
    // profile tabs
    var profileTabs = [TwoString]()
    var secondPersonProfileTabs:[(identifier:String,title:String,storyBoard:String)] = [(identifier:String,title:String,storyBoard:String)]()

    // Person info items
    var basicInfoItems = [String]()
    var contactInfoItems = [String]()
    var educationInfoItems = [String]()
    var occupationInfoItems = [String]()
    
    var nHomeTabs = 1
    var briefViewXibName = "BriefProfileBar"
    var briefType:BriefProfilePersonType = BriefProfilePersonType.Resident
    
    var homeFilters = Constants.residentHomeIssueFilter
    
    
    var donationType : DonationType!
    
    init(){
        educationInfoItems = ["LAST_DEGREE_HELD".localized,"YEAR".localized]
        occupationInfoItems = [MyStrings.designation,MyStrings.workPlace,MyStrings.from, MyStrings.TO]
        personSpecificParmeter()
    }
    
    func personSpecificParmeter(){
        assertionFailure("method must be overriden")
    }
    
    func getInfoItemBy(index :PersonBasicInfoType) -> [String]{
        switch (index){
        case .Basic:
            return basicInfoItems
        case .Contact:
            return contactInfoItems
        case .Education:
            return educationInfoItems
        case .Occupation:
            return occupationInfoItems
            
        }
    }
    
        func getTextFieldDataBy(index:Int)->[TextFieldInputData]?{
            return nil
        }
        
}

