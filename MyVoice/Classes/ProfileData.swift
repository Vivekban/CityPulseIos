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
    var politicalPartyImage = ""
   var position = ""
    
    var followers = 0
    var badges = 0
    var credits = 0
    var issueResolved = 0
    var donations = 0
    var donated = 0

    var reviews = 0
    var issueRaised = 0
    
    var replies = 0
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        credits <- map["credits"]
        badges <- map["badges"]
        donations <- map["donation"]
        donated <- map["donated"]

        issueResolved <- map["issue_resolved"]
        reviews <- map["reviews"]
        followers <- map["followers"]
        followers <- map["issue_raised"]
        replies <- map["replies"]

    }
    
    func takeDataFromBasicInfo(data:PersonBasicData?){
        if let d = data {
            profileImageUrl = d.profilePic
            name = d.first_name
            area = d.address1
            politicalPary = d.political_party
            politicalPartyImage = d.partyPic
            position = d.position
        }
    }
}