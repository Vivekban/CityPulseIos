//
//  CommunityHubDataTypes.swift
//  MyVoice
//
//  Created by PB014 on 26/05/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import ObjectMapper

class CommunityItemData: TitleDescriptionData {

    var issueRaised = 0
    var credits = 0
    var picUrl = ""
    
    override func mapping(map: Map) {
        super.mapping(map)
        title <- map["name"]
        description <- map["detail"]
        issueRaised <- map["issue_raised"]
        credits <- map["credits"]
        picUrl <- map["img_url"]

        
    }

}
