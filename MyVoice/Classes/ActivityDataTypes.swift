//
//  ActivityDataTypes.swift
//  MyVoice
//
//  Created by PB014 on 11/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper


class CreditsData: TitleDescriptionData {
    var level = 0
    var creditREquired = 0
    
    
    override func mapping(map: Map) {
        super.mapping(map)
        level <- map["level"]
        creditREquired <- map["credits"]
    }
}

class BadgesData: TitleDescriptionData {
    var level = 0
    var count = 0
    
    
    override func mapping(map: Map) {
        super.mapping(map)
        level <- map["level"]
        count <- map["credits"]
    }
}


class DonationData: TitleDescriptionData {
    var serialNo = 0
    var total = 0
    var actual = 0
    var tranferredStatus = ""
    var ownerName = ""
    var date = ""
    
    
    override func mapping(map: Map) {
        super.mapping(map)
        serialNo <- map["srn"]
        total <- map["total"]
        
    }
}


