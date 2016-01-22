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
    var owner:Double = 0
    init(){
        owner = 1
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        owner <- map["owner"]
    }
    
    func isReadyToSave() -> String {
        //preconditionFailure("overrider it")
        return ""
    }
    
}

class TitleDescriptionData: BaseData {
    var title:String = ""
    var description:String = ""
    
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
    var date:String = ""
    
    override func mapping(map: Map) {
        super.mapping(map)
        date <- map["datetime"]
    }
    
}


class ImageUrlData : TitleDescriptionData{
    var imagesUrls = [String]()
    override func mapping(map: Map) {
        super.mapping(map)
        imagesUrls <- map["imageUrls"]
    }
}



