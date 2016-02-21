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
    
    case BasicInfo = 1, Views, Reviews, Profile, Work, Video, Event
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
            return "";
        }

    }
    
    override func getParamterBasedOnRequest(dataRequest: Int, parameter:[String : AnyObject]? = nil) -> [String : AnyObject] {
        let infoRequest = PersonInfoRequestType(rawValue: dataRequest)!

        switch (infoRequest) {
        case .Reviews:
            return ["userid":"\(userId)"]
        default:
            break;
        }
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
            var list = [MyViewData]()
            for (_,obj) in viewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<MyViewData>().map(finalString) {
                        list.append(view)
                    }
                }
            }
            person.viewsListManager.updateEntries(list)

            break
        case .Reviews:
            let reviewArray = JSON(data)
            var list = [ReviewData]()
            for (_,obj) in reviewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<ReviewData>().map(finalString) {
                        list.append(view)
                    }
                }
            }
            person.reviewssListManager.updateEntries(list)

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
    
    override func fetchListData(dataRequest: Int, parameter: [String : AnyObject], completionHandler: ServerRequestCallback?) {
        
        // let infoRequest = IssueInfoRequestType(rawValue: dataRequest)!
        // let tab = parameter["tab"] as! Int
        // let index = parameter["index"] as! Int
        
        
        
        let lists =  person.getList(dataRequest)
        
        if lists.hasAllEntries {
            if let handler = completionHandler {
                handler(ServerResult.EveryThingUpdated)
                return
            }
        }
        
        if lists.isFetching {
            if let handler = completionHandler {
                handler(ServerResult.UnderProgress)
                return
            }
        }
        
        //TODO: parameter
        var para = [String:AnyObject]()
        
        MyUtils.addDictionary(&para, rhs: parameter)
        MyUtils.addDictionary(&para, rhs: getParamterBasedOnRequest(dataRequest))
        
        super.fetchListData(dataRequest, parameter: para, completionHandler: completionHandler)
        
    }

    
    
}
