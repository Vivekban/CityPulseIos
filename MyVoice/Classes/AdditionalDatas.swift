//
//  AdditionalDatas.swift
//  MyVoice
//
//  Created by PB014 on 25/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper



class ReviewData : TitleDesDateData {
    var reviewerName = ""
    var sentiment = 0
    override func mapping(map: Map) {
        super.mapping(map)
        reviewerName <- map["name"]
        sentiment <- map["sentiment"]
    }
}

