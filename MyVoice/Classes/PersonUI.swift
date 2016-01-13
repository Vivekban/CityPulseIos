//
//  PersonUI.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

/// Base model class for PersonUI cantain blueprint of PersonUI


class PersonUI {
    // Person info items
    var basicInfoItems = [String]()
    var contactInfoItems = [String]()
    var educationInfoItems = [String]()
    var occupationInfoItems = [String]()
    
    var nHomeTabs = 1
    var briefViewXibName = "BriefProfileBar"
    var breifViewCollectionRect = CGRectMake(0, 0, 220, 80)
    var briefViewItems = [BriefItemUI]()
    
    init(){
        educationInfoItems = ["LAST_DEGREE_HELD".localized,"YEAR".localized]
        occupationInfoItems = ["COMPANY".localized,"TITLE".localized,"FROM".localized, "TO".localized]
    }
    
    func getInfoItemBy(index :Int) -> [String]{
        switch (index){
        case 0:
        return basicInfoItems
        case 1:
        return contactInfoItems
        case 2:
        return educationInfoItems
        case 3:
        return occupationInfoItems
        default:
            assertionFailure()
        }
        return basicInfoItems
    }
    
    func getTextFieldDataBy(index:Int)->[TextFieldInputData]?{
        return nil
    }
}