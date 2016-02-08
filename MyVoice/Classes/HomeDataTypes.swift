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
    var markTo:String = "0"
    var isCritical = false
    var location:Location?
    var status:String = ""
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        if markTo.isEmpty {
            markTo = "0"
        }
        
        category <- map["category"]
        tags <- map["tags"]
        markTo <- map["mark_to"]
        isCritical <- map["critical"]
        category <- map["category"]
        status <- map["status"]
    }
    
}

class CommentData:TitleDesDateData {
    var reply:[CommentData]?
    var ownerName:String = ""
    var ownerPic:String = ""
    var ownerArea:String = ""
    
    func getTotalComments()-> Int {
        var sum = 0
        
        if reply != nil {
            for i in reply! {
                sum++
                sum += i.getTotalComments()
            }
        }
        
        return sum
    }
}

class ResponseData:CommentData {
    var votes = 0
    
}