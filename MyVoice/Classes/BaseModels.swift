//
//  BaseModels.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper



// Data types....

class BaseData:Mappable{
    var userid:Int = 0
    var id:Int = 0
    var owner = ""
    init(){
        userid = 1//CurrentSession.i.userId
        owner = "\(userid)"
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        userid <- map["userid"]
        id <- map["id"]
        owner <- map["owner"]
    }
    
    func isReadyToSave() -> String {
        //preconditionFailure("overrider it")
        return ""
    }
    
}

class TitleDescriptionData: BaseData {
    var title:String = "" {
        didSet{
            let trimString =  MyUtils.makeStringTrimmed(title)
            if trimString != title {
                 title = trimString
            }
        }
    }

    var description:String = ""{
        didSet{
            let trimString =  MyUtils.makeStringTrimmed(description)
            if trimString !=  description{
            description = trimString
            }
        }
    }

    
    override func mapping(map: Map) {
        super.mapping(map)
        title <- map["title"]
        description <- map["description"]
    }
    
    override func isReadyToSave() -> String {
        if title.isEmpty {
            return MyStrings.messageTitleEmpty
        }
        else if description.isEmpty {
            return MyStrings.messageDescriptionIsEmpty
        }
        return ""
    }
}

class TitleDesDateData :TitleDescriptionData{
    private var date:String = ""
    var disPlayDate:String {
        get {
            if !date.isEmpty {
                if date.containsString("-"){
                    return TimeDateUtils.getClientStyleDateFromServerString(date)
                }
            }
            return TimeDateUtils.getShortDateInString(NSDate())

        }
        
        set (newValue) {
            if !newValue.isEmpty {
                if newValue.containsString(","){
                    date = TimeDateUtils.getServerStyleDateInString(newValue)
                    return
                }
            }
            date = newValue
        }
    }
    override func mapping(map: Map) {
        super.mapping(map)
        date <- map["datetime"]
    }
    
}


class ImageUrlData : TitleDesDateData{
    var imagesUrls = [String]()
    override func mapping(map: Map) {
        super.mapping(map)
        imagesUrls <- map["imageUrls"]
    }
}



