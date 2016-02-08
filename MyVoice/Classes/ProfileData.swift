//
//  ProfileData.swift
//  MyVoice
//
//  Created by PB014 on 23/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileData: BaseData {
    var type = ""
    var profileImageUrl = ""
    var name = ""
    var area = ""
    var politicalPary = ""
    var followers = 0
    var badges = 0
    var credits = 0
    var issue = 0
    var donations = 0
    var reviews = 0
    
    
    override func mapping(map: Map) {
        super.mapping(map)
    }
}