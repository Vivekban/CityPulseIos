//
//  CurrentSession.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class CurrentSession {
    
   static let i = CurrentSession()
    
    private init(){
        personUI = LeaderUI()
        mainPersonUI = personUI
        secondaryPersonUI = ResidentUI()
        var id = NSUserDefaults.standardUserDefaults().doubleForKey(PermanentDataKey.userId)
        
        if Constants.isDebug {
            id = Constants.tempUserId
        }
        
         personController = PersonController(userID: id)
        mainPersonController = personController
    }
    
    var personUI:PersonUI? // current person
    var mainPersonUI:PersonUI?
    var secondaryPersonUI:PersonUI?
    
    // controller
    
    var personController:PersonController!
    var mainPersonController:PersonController!
    
}