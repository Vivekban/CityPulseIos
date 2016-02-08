//
//  ProfileStructs.swift
//  MyVoice
//
//  Created by PB014 on 11/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import ObjectMapper
// MARK: Supporting




// MARK: Info

class InfoData : BaseData{
    var content: String = "" {
        didSet{
            let trimString =  MyUtils.makeStringTrimmed(content)
            if trimString != content {
                content = trimString
            }
        }
    }
    override func mapping(map: Map) {
        super.mapping(map)
        content <- map["content"]
    }
}



// MARK: Views

class MyViewData :TitleDesDateData{

}

// MARK: Work

class MyWorkData:ImageUrlData {
    var likes = 0
    var comments = 0
    var category = "Category"
     override func mapping(map: Map) {
        super.mapping(map)
        likes <- map["likes"]
        comments <- map["comments"]
        category <- map["category"]
    }
}


// MARK: Event


class EventData:ImageUrlData{
    var startTime: String = ""
    var endTime: String = ""
    var allDayEvent = false
    var location:Location?
    var website:String = ""
    
    override func mapping(map: Map) {
        super.mapping(map)
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        location <- map["location"]
        website <- map["website"]

    }
    
    override func isReadyToSave() -> String {
        if startTime.isEmpty {
            return MyStrings.messageStartDateEmpty
        }
        else if endTime.isEmpty {
            return MyStrings.messageEndDateEmpty
        }
    
        return ""
    }
}


//MARK: Video

class MyVideo: BaseData {
    
}