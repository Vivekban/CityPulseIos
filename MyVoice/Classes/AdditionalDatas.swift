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
    
    override func mapping(map: Map) {
        reviewerName <- map["name"]
    }
}