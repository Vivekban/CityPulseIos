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
    var markTo:Int = -1
    var isCritical = false
    var location:Location?
    var status:String = "n"
    
    var isSubscribed = 0
    var isFlaged = 0
    var isVoted = 0
    
    var displayStatus :String{
        get {
            if !status.isEmpty {
                if status.caseInsensitiveCompare("n") == .OrderedSame{
                    return MyStrings.open
                }
                else {
                    MyStrings.closed
                }
            }
            return MyStrings.open
        }
        
        set (newValue) {
            if !newValue.isEmpty {
                    status = "\(newValue.characters[newValue.startIndex])"
                    return
            }
            status = "n"
        }

    }
    
    var votes:Int = 0
    var responseCount:Int = 0
    
    var ownerName = ""
    var ownerPic = ""
    var ownerArea = ""
    var ownerCredits = ""
    
    var comments:[CommentData]?
    var response:[ResponseData]?
    
    override func mapping(map: Map) {
        super.mapping(map)
        category <- map["category"]
        tags <- map["tags"]
        markTo <- map["mark_to"]
        isCritical <- map["critical"]
        category <- map["category"]
        status <- map["status"]
        responseCount <- map["response_count"]
        
        id <- map ["issueid"]
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
    
    override func mapping(map: Map) {
        super.mapping(map)
        ownerName <- map["ownername"]
    }
    
    func initWithOwner(info : PersonBasicData ){
        disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
        ownerName = info.first_name
        ownerArea = info.address1
        ownerPic = info.profilePic
    }
}

class ResponseData:CommentData {
    var votes = 0
    
}

class PostCommentData : BaseData {
    var issueid : Int = 0
    var comment = ""
    override func mapping(map: Map) {
        super.mapping(map)
        issueid <- map["issueid"]
        comment <- map["comment"]

    }
}


class PollData:ImageUrlData {
    
}


enum IssueType : Int{
    case Community = 0, HOA
}



