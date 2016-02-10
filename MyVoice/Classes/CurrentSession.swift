//
//  CurrentSession.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import CoreLocation


class CurrentSession {
    
   static let i = CurrentSession()
    
    var userId:Int = 0
    
    var userLocation:CLLocation?
    var userPlacemark:CLPlacemark?

    
    private init(){
        personUI = LeaderUI()
        mainPersonUI = personUI
        secondaryPersonUI = ResidentUI()
        userId = NSUserDefaults.standardUserDefaults().integerForKey(PermanentDataKey.userId)
        
        if Constants.isDebug {
            userId = Constants.tempUserId
        }
    
        
        personController = PersonController(userID: userId)
        mainPersonController = personController
        
        issueController = IssueController()
    }
    
    var personUI:PersonUI? // current person
    var mainPersonUI:PersonUI?
    var secondaryPersonUI:PersonUI?
    
    // controller
    
    var personController:PersonController!
    var mainPersonController:PersonController!
    var secondaryPersonController:PersonController!

    // MARK: - issues

    var issueController:IssueController!
    
    var recentrlyEditedData:[BaseData]?
    
}