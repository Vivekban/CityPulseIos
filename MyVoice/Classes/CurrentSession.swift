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
        userId = NSUserDefaults.standardUserDefaults().integerForKey(PermanentDataKey.userId)
    }
    
    func initVariable(){
        personUI = LeaderUI()
        mainPersonUI = personUI
        secondaryPersonUI = ResidentUI()
        
        if Constants.isDebug {
            userId = Constants.tempUserId
        }
        
        
        personController = PersonController(userID: userId)
        mainPersonController = personController
        
        appDataController = AppDataController()
        issueController = HomeDataManager()
        
    }
    
    var personUI:PersonUI? // current person
    var mainPersonUI:PersonUI?
    var secondaryPersonUI:PersonUI?
    
    // controller
    
    var personController:PersonController!
    var mainPersonController:PersonController!
    var secondaryPersonController:PersonController!
    
    // MARK: - issues
    
    var issueController:HomeDataManager!
    
    var appDataController:AppDataController!
    
    var recentrlyEditedData:[BaseData]?
    
    func isVisitingSomeone() -> Bool {
        return mainPersonController != personController
    }
    
    func isLeader() -> Bool{
        if let _ = personUI as? LeaderUI {
            return true
        }
        return false
    }
    
}