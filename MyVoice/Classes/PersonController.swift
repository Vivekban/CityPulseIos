//
//  PersonController.swift
//  MyVoice
//
//  Created by PB014 on 25/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON


enum PersonInfoRequestType:Int{
    
    case BasicInfo = 1, Views, Reviews, Profile
}

class PersonController : ServerDataManager {
    var person:PersonData = PersonData()
    var userId:Int!
    
    init(userID:Int){
        super.init()
        self.userId = userID
        // CurrentSession.i.userId = userID
       // getUserViews(nil)
       // getUserInfo(nil)
        
        fetchData(PersonInfoRequestType.BasicInfo.rawValue, completionHandler: nil)

        fetchData(PersonInfoRequestType.Views.rawValue, completionHandler: nil)

    }
    
    
    
    
    override func getUrlBasedOnRequest(dataRequest: Int) -> String {
        let infoRequest = PersonInfoRequestType(rawValue: dataRequest)!

        switch (infoRequest) {
        case .BasicInfo:
            return ServerUrls.getUserDetailsUrl
        case .Reviews:
            return ServerUrls.getReviewByOwnerUrl
        case .Views:
            return ServerUrls.getViewByUserIdUrl
        case .Profile:
            return ServerUrls.getUserProfileDetailsUrl
        default:
            break;
        }

    }
    
    override func getParamterBasedOnRequest(dataRequest: Int, parameter:[String : AnyObject]? = nil) -> [String : AnyObject] {
       return ["userid":"\(userId)"]
    }
    
    override func onSuccesfulRequset(dataRequest:Int , parameter:[String : AnyObject]? = nil, data:AnyObject){
        let infoRequest = PersonInfoRequestType(rawValue: dataRequest)!

        switch (infoRequest) {
        case .BasicInfo:
            //print(data)
            if let d = Mapper<PersonBasicData>().map(data){
            person.basicInfo  = d
            person.basicInfo.userid = userId
            }
            fetchData(PersonInfoRequestType.Profile.rawValue, completionHandler: nil)

            break;
        case .Views:
            let viewArray = JSON(data)
            person.views.removeAll()
            for (_,obj) in viewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<MyViewData>().map(finalString) {
                        person.views.append(view)
                    }
                }
            }
            break
        case .Reviews:
            let reviewArray = JSON(data)
            person.reviews.removeAll()
            for (_,obj) in reviewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<ReviewData>().map(finalString) {
                        person.reviews.append(view)
                    }
                }
            }
            break
        case .Profile:
            print(data)
            if let d = Mapper<ProfileData>().map(data) {
                person.profileData  = d
                person.profileData.takeDataFromBasicInfo(person.basicInfo)
                EventUtils.postNotification(EventUtils.basicInfoUpdateKey)

            }

        default:
            break;
        }
        
    }
    
}
