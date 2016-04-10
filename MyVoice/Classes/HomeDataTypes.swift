//
//  HomeDataTypes.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class IssueData: ImageUrlData {
    var category:String = ""
    var tags:String = ""
    var markTo:Int = -1
    var isCritical = false
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
    var ownerCredits = 0
    
    var comments:[CommentData]?
    var response:[ResponseData]?
    
    override func mapping(map: Map) {
        super.mapping(map)
        category <- map["category"]
        tags <- map["tags"]
        markTo <- map["markTo"]
        isCritical <- map["isCritical"]
        category <- map["category"]
        status <- map["status"]
        responseCount <- map["response_count"]
        isFlaged <- map["isFlaged"]
        isVoted <- map["isVoted"]
        isSubscribed <- map["isSubscribed"]
        
        ownerArea <- map["ownerArea"]
        ownerCredits <- map["ownerCredits"]
        ownerName <- map["ownerName"]
        ownerPic <- map["ownerPic"]
        
        response <- map["responses"]
        
        id <- map ["issueid"]
    }
    
    func addComment(data : CommentData){
        if comments == nil {
            comments = [CommentData]()
        }
        comments?.append(data)
    }
    
    func addResponse(data : ResponseData){
        if response == nil {
            response = [ResponseData]()
        }
        response?.append(data)
    }
    
    
    override func update(data :BaseData , isForce :Bool = false){
        super.update(data, isForce: isForce)
        guard let d = data as? IssueData else {
            return
        }
        
        
        response = d.response
        responseCount = d.responseCount > responseCount || isForce ? d.responseCount: responseCount
        isFlaged = d.isFlaged
        isVoted = d.isVoted
        isSubscribed = d.isSubscribed
        ownerCredits = d.ownerCredits > ownerCredits || isForce ? d.ownerCredits: ownerCredits
        title = !d.title.isEmpty || isForce ? d.title : title
        ownerPic = !d.ownerPic.isEmpty || isForce ? d.ownerPic: ownerPic
        ownerName = !d.ownerName.isEmpty || isForce ? d.ownerName: ownerName
        ownerArea = !d.ownerArea.isEmpty || isForce ? d.ownerArea: ownerArea
        category = !d.category.isEmpty || isForce ? d.category: category
        tags = !d.tags.isEmpty || isForce ? d.tags: tags
        markTo = d.markTo > markTo || isForce ? d.markTo: markTo

    }

    
}

class CommentData:TitleDesDateData {
    var reply:[CommentData]?
    var ownerName:String = ""
    var ownerPic:String = ""
    var ownerArea:String = ""
    var isFlaged = 0
    
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
        ownerArea <- map["ownerArea"]
        ownerName <- map["ownerName"]
        ownerPic <- map["ownerPic"]
        owner <- map["ownerId"]
        isFlaged <- map["isFlaged"]
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
    var isVoted = 0
    
    override func mapping(map: Map) {
        super.mapping(map)
        votes <- map["votes"]
        isVoted <- map["isVoted"]
    }

    
}

class PostCommentData : BaseData {
    var issueid : Int = 0
    var comment = ""
    override func mapping(map: Map) {
        super.mapping(map)
        issueid <- map["issueid"]
        comment <- map["comment"]

    }
    override func isReadyToSave() -> String {
        if comment.isEmpty {
            return MyStrings.messageEmpty
        }
        else if comment.characters.count < 20 {
            return MyStrings.messageIsTooShort
        }
        return ""
    }
}


class PollData:ImageUrlData {
    var category:String = ""
    var isVoted = 0
    var supporters = 0
    var opposers = 0

}


enum IssueType : Int{
    case Community = 0, HOA
}



