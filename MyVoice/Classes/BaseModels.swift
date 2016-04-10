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
    var owner = 0
    init(){
        userid = CurrentSession.i.userId
        owner = userid
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
    
    func getCombineString() -> String {
        let s = userid.toString() + id.toString() + owner.toString()
        // print("combine Stirng .......\(s)")
        return s
    }
    
    func update(data :BaseData , isForce :Bool = false){
        userid = data.userid != 0 || isForce ? data.userid : userid
        id = data.id != 0 || isForce ? data.id : id
        owner = data.owner != 0 || isForce ? data.owner : owner
    }
    
}

extension BaseData : Hashable {
    
    var hashValue: Int {
        return getCombineString().hashValue
    }
    
    
}

extension BaseData : Equatable {}

func ==(lhs: BaseData, rhs: BaseData) -> Bool {
    
    return lhs.userid == rhs.userid &&
        lhs.id != rhs.id &&
        lhs.owner != rhs.owner
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
    
    override func getCombineString() -> String {
        return (super.getCombineString() + title + description)
    }
    
    override func update(data :BaseData , isForce :Bool = false){
        super.update(data, isForce: isForce)
        guard let d = data as? TitleDescriptionData else {
            return
        }
        title = !d.title.isEmpty || isForce ? d.title : title
        description = !d.description.isEmpty || isForce ? d.description: description
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
    
    func getNSDate() -> NSDate {
        if !date.isEmpty {
            if date.containsString("-"){
                return TimeDateUtils.getDateFromServerString(date)
            }
        }
        return NSDate()
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        date <- map["datetime"]
    }
    
}


class ImageUrlData : TitleDesDateData{
    var imagesUrls = [String]()
    var location:Location?
    
    override func mapping(map: Map) {
        
        super.mapping(map)
        
        imagesUrls <- map["imgurls"]
        location <- map["location"]

        var singleUrl:String = ""
         singleUrl <- map["imgurl"]

        if !singleUrl.isEmpty && imagesUrls.count == 0 {
            imagesUrls.append(singleUrl)
        }

    }
    
    override func update(data :BaseData , isForce :Bool = false){
        super.update(data, isForce: isForce)
        guard let d = data as? ImageUrlData else {
            return
        }
        if (d.imagesUrls.count > imagesUrls.count || isForce ){
            self.imagesUrls.removeAll();
            self.imagesUrls.appendContentsOf(d.imagesUrls);
        }
    }

}



