//
//  ProfileStructs.swift
//  MyVoice
//
//  Created by PB014 on 11/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
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

    override func mapping(map: Map) {
        super.mapping(map)
        id <- map["viewId"]
    }
    
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



class SentimentTimelineData: BaseData {
    var label = ""
    var value = 0
    
    override func mapping(map: Map) {
        label <- map["label"]
        value <- map["data"]
    }
}

class ReviewAnalyticsData: SentimentTimelineData {
    var reviews = [ReviewData]()
    //var string = ""
    
    override func mapping(map: Map) {
        super.mapping(map)
        label <- map["label"]
        value <- map["data"]
        if let data = map["ar"].currentValue {
        let array = JSON(data)
        for (_,obj) in array {
            if let finalString = obj.rawString() {
                // print(" value is \(i)...+....\(finalString)")
                if let view = Mapper<ReviewData>().map(finalString) {
                    reviews.append(view)
                }
            }
          }
        }
        
    }
}

// MARK: - PersonBasicData


class PersonBasicData : BaseData{
    var user_type = PersonType.RESIDENT.rawValue
    var password:String = ""
    var initials:String = ""
    var first_name:String = ""
    var twitter :String = ""
    var dob	 :String = ""
    var gender:String = ""
    var political_party:String = ""
    var marital_status:String = ""
    var issue_care	 :String = ""
    var city_care	 :String = ""
    var address1	 :String = ""
    var city	 :String = ""
    var zip	 :String = ""
    var landline	 :String = ""
    var mobile	 :String = ""
    var facebook	 :String = ""
    var linkedin	 :String = ""
    var email	 :String = ""
    var last_degree	 :String = ""
    var degree_year	 :String = ""
    var company	 :String = ""
    var position	 :String = ""
    var occupation_time_from :String = ""
    var occupation_time_to :String = ""
    
    var profilePic :String = ""
    var partyPic :String = ""
    
    
    override init() {
        super.init()
        dob = TimeDateUtils.getShortDateInString(NSDate())
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func isReadyToSave() -> String {
        if first_name.isEmpty {
            return MyStrings.messageNameEmpty
        }
        else if  dob.isEmpty {
            return MyStrings.messageDobEmpty
        }
        
        return ""
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        // id <- map["id"]
        // owner <- map["owner"]
        if gender.characters.count > 1 {
            gender = "\(gender[gender.startIndex])"
        }
        if marital_status.characters.count > 1 {
            marital_status = "\(marital_status[marital_status.startIndex])"
        }
        
        
        if dob.containsString(",") {
            dob = TimeDateUtils.getServerStyleDateInString(dob)
        }
        if occupation_time_from.containsString(",") {
            occupation_time_from = TimeDateUtils.getServerStyleDateInString(occupation_time_from)
        }
        if occupation_time_to.containsString(",") {
            occupation_time_to = TimeDateUtils.getServerStyleDateInString(occupation_time_to)
        }
        
        user_type  <- map["user_type"]
        password <- map["password"]
        initials <- map["initials"]
        first_name <- map["first_name"]
        //   last_name    <- map["last_name"]
        dob	         <- map["dob"]
        gender       <- map["gender"]
        political_party  <- map["political_party"]
        marital_status <- map["marital_status"]
        issue_care <- map["issue_care"]
        city_care <- map["city_care"]
        address1 <- map["add1"]
        city	   <- map["city"]
        zip	  <- map["zip"]
        landline <- map["landline"]
        mobile	  <- map["mobile"]
        facebook <- map["facebook"]
        linkedin <- map["linkedin"]
        email	  <- map["email"]
        last_degree <- map["last_degree"]
        degree_year <- map["degree_year"]
        company <- map["company"]
        //    occupation_name <- map["occupation_name"]
        position <- map["position"]
        occupation_time_from <- map["occupation_time_from"]
        occupation_time_to <- map["occupation_time_to"]
        
        twitter <- map["twiter"]
        
        profilePic <- map["imgurl"]
        partyPic <- map["pimgurl"]
    }
    
    func getValueBy(section :PersonBasicInfoType , row:Int) -> String? {
        
        switch (section){
        case .Basic:
            
            switch row {
            case 0:
                return first_name
            case 1:
                if marital_status.characters.count == 1 {
                    return marital_status.caseInsensitiveCompare("S") == .OrderedSame ? MyStrings.single:MyStrings.married
                }
                return marital_status
            case 2:
                if dob.containsString("-") {
                    return TimeDateUtils.getClientStyleDateFromServerString(dob)
                }
                return dob
            case 3:
                return city_care
            case 4:
                if gender.characters.count == 1 {
                    return gender.caseInsensitiveCompare("M") == .OrderedSame ? MyStrings.male:MyStrings.female
                }
                return gender
            case 5:
                return issue_care
            case 6:
                return political_party
            default:
                assertionFailure()
            }
            
        case .Contact:
            switch row {
            case 0:
                return address1
            case 1:
                return facebook
            case 2:
                return city
            case 3:
                return twitter
            case 4:
                return zip
            case 5:
                return linkedin
            case 6:
                return mobile
            case 7:
                return email
            default:
                assertionFailure()
            }
        case .Education:
            switch row {
            case 0:
                return last_degree
            case 1:
                return degree_year
            default:
                assertionFailure()
            }
        case .Occupation:
            switch row {
            case 0:
                return company
            case 1:
                return position
            case 2:
                return occupation_time_from
            case 3:
                return occupation_time_to
            case 4:
                break
            default:
                assertionFailure()
            }
            
        }
        return ""
    }
    
    func setValueBy(section :PersonBasicInfoType , row:Int , value: String) {
        
        switch (section){
        case .Basic:
            
            switch row {
            case 0:
                first_name = value
                break
            case 1:
                marital_status = value
                break
            case 2:
                dob = value
                break
            case 3:
                city_care = value
                break
            case 4:
                gender = value
                break
            case 5:
                issue_care = value
                break
            case 6:
                political_party = value
                break
            default:
                assertionFailure()
            }
            
        case .Contact:
            switch row {
            case 0:
                address1 = value
                break
            case 1:
                facebook = value
                break
            case 2:
                city = value
                break
            case 3:
                twitter = value
                break
            case 4:
                zip = value
                break
            case 5:
                linkedin = value
                break
            case 6:
                mobile = value
                break
            case 7:
                email = value
                break
            default:
                assertionFailure()
            }
        case .Education:
            switch row {
            case 0:
                last_degree = value
                break
            case 1:
                degree_year = value
                break
            default:
                assertionFailure()
            }
        case .Occupation:
            switch row {
            case 0:
                company = value
                break
            case 1:
                position = value
                break
            case 2:
                occupation_time_from = value
                break
            case 3:
                occupation_time_to = value
                break
            case 4:
                break
            default:
                assertionFailure()
            }
        }
        
        
    }
    
    
    
    
    
    enum PersonType:String{
        case RESIDENT = "R";
        case LEADER = "L"
    }
}
