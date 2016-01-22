//
//  HomeDataTypes.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper

class IssueData: ImageUrlData {
    var category:String = ""
    var tags:String = ""
    var markTo:String = ""
    var isCritical = false
    var date:String = ""
    var location:Location?
    var status:String = ""
    
    override func mapping(map: Map) {
        category <- map["category"]
        tags <- map["tags"]
        markTo <- map["mark_to"]
        isCritical <- map["critical"]
        category <- map["category"]
        date <- map["datetime"]
        status <- map["status"]
    }
    
}