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
    var isEditingEnable = true
    
    
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
        
        
        personController = PersonDataManager(userID: userId)
        mainPersonDataManager = personController
        
        appDataManager = AppDataManager()
        issueController = HomeDataManager()
        publicFigureDataManager = PublicFigureDataManager()
        
    }
    
    var personUI:PersonUI? // current person
    var mainPersonUI:PersonUI?
    var secondaryPersonUI:PersonUI?
    
    // MARK: -  Data Managers
    
    var personController:PersonDataManager!
    var mainPersonDataManager:PersonDataManager!
    var secondaryPersonDataManager:PersonDataManager!
    
    
    var issueController:HomeDataManager!
    
    var publicFigureDataManager : PublicFigureDataManager!
    
    
    var appDataManager:AppDataManager!
    
    var recentrlyEditedData:[BaseData]?
    
    func isVisitingSomeone() -> Bool {
        return mainPersonDataManager != personController
    }
    
    func isLeader() -> Bool{
        if let _ = personUI as? LeaderUI {
            return true
        }
        return false
    }
    
}