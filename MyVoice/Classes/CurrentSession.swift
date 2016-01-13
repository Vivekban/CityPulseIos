//
//  CurrentSession.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import Foundation

class CurrentSession {
    
   static let i = CurrentSession()
    
    private init(){
        personUI = LeaderUI()
        mainPersonUI = LeaderUI()
        secondaryPersonUI = ResidentUI()
    }
    
    var personUI:PersonUI?
    var mainPersonUI:PersonUI?
    var secondaryPersonUI:PersonUI?
    
}