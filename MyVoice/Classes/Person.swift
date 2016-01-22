//
//  Person.swift
//  MyVoice
//
//  Created by PB014 on 14/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class PersonController {
    var person:Person!
    var userId:Double!
    
    init(userID:Double){
        self.userId = userID
        person = Person()
        getUserViews(nil)
        getUserInfo(nil)
        
    }
    
    func getUserInfo(completionHandler:ServerRequestCallback?){
        let uInfoRequest = ServerRequest(url: ServerUrls.getUserDetailsUrl, postData: ["userid":"\(userId)"]) { (result) -> Void in
            
            if let cH = completionHandler {
                cH(result)
            }
            
            switch result {
            case .Success(let data):
                if let d = data {
                    print(d)
                    self.person.basicInfo  = Mapper<PersonBasicData>().map(data)!
                    
                    
                }
                break
            case .Failure(let error):
                print(error)
                
            }
        }
        ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
        
        
    }
    
    func getUserViews(completionHandler:ServerRequestCallback?){
        let uInfoRequest = ServerRequest(url: ServerUrls.getViewByUserIdUrl, postData: ["userid":"\(userId)"]) { (result) -> Void in
            
            if let cH = completionHandler {
                cH(result)
            }
            
            switch result {
            case .Success(let data):
                if let d = data {
                    // print(d)
                    
                    let viewArray = JSON(d)
                    self.person.views.removeAll()
                    for (i,obj) in viewArray {
                        if let finalString = obj.rawString() {
                            // print(" value is \(i)...+....\(finalString)")
                            if let view = Mapper<MyViewData>().map(finalString) {
                                self.person.views.append(view)
                            }
                        }
                    }
                    // person.basicInfo  = Mapper<PersonBasicData>().map(data)
                    
                    
                }
                break
            case .Failure(let error):
                print(error)
                
            }
        }
        ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
    }
    
}

class Person{
    var basicInfo:PersonBasicData = PersonBasicData()
    var views:[MyViewData] = [MyViewData]()
    var work:[MyWorkData] = [MyWorkData]()
    var event:[EventData] = [EventData]()
    var video:[MyVideo] = [MyVideo]()
    
    init(){
    }
}


class PersonBasicData : BaseData{
    var user_type = PersonType.RESIDENT.rawValue
    var password:String?
    var initials:String?
    var first_name:String?
    var dOB	 :String?
    var gender:String?
    var political_party:String?
    var maritial_status:String?
    var issue_care	 :String?
    var city_care	 :String?
    var address1	 :String?
    var city	 :String?
    var zip	 :String?
    var landline	 :String?
    var mobile	 :String?
    var facebook	 :String?
    var linkedin	 :String?
    var twitter :String?
    var email	 :String?
    var last_degree	 :String?
    var degree_year	 :String?
    var company	 :String?
    var position	 :String?
    var occupation_time_from :String?
    var occupation_time_to :String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func isReadyToSave() -> String {
        if let name = first_name {
            if name.isEmpty {
                return MyStrings.messageNameEmpty
            }
        }
        else {
            return MyStrings.messageNameEmpty
        }
        
        return ""
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        user_type  <- map["user_type"]
        password <- map["password"]
        initials <- map["initials"]
        first_name <- map["first_name"]
        //   last_name    <- map["last_name"]
        dOB	         <- map["dOB"]
        gender       <- map["gender"]
        political_party  <- map["political_party"]
        maritial_status <- map["maritial_status"]
        issue_care <- map["issue_care"]
        city_care <- map["city_care"]
        address1 <- map["address1"]
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
        
        twitter <- map["twitter"]
    }
    
    func getValueBy(section :PersonInfoType , row:Int) -> String? {
        
        switch (section){
        case .Basic:
            
            switch row {
            case 0:
                return first_name
            case 1:
                return maritial_status
            case 2:
                return dOB
            case 3:
                return city_care
            case 4:
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
    
    func setValueBy(section :PersonInfoType , row:Int , value: String) {
        
        switch (section){
        case .Basic:
            
            switch row {
            case 0:
                first_name = value
                break
            case 1:
                maritial_status = value
                break
                
            case 2:
                dOB = value
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
        case RESIDENT = "Resident";
        case LEADER = "Leader"
    }
}