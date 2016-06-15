//
//  MeDataManager.swift
//  MyVoice
//
//  Created by PB014 on 25/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON


enum PersonInfoRequestType:Int{
    
    case BasicInfo = 1, Views, Reviews, Profile, Work, Video, Event , SentimentTimeLine, SentimentMap,ReviewAnalysis, Credits,Donations,PageView,Badges
}

class PersonDataManager : ServerDataManager {
    var person:MeData = MeData()
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
        case .SentimentTimeLine:
            return ServerUrls.getSentimentTimelineUrl
        case .ReviewAnalysis:
            return ServerUrls.getReviewAnalyticsUrl
        case .Work:
            return ServerUrls.getWorkUrl
        case .Event:
            return ServerUrls.getEventByIdUrl
        default:
        return "";
        }
        
    }
    
    override func getParamterBasedOnRequest(dataRequest: Int, parameter:[String : AnyObject]? = nil) -> [String : AnyObject] {
        let infoRequest = PersonInfoRequestType(rawValue: dataRequest)!
        
        switch (infoRequest) {
        case .Reviews:
            return ["userid":"\(userId)"]
            
        case .Work:
            return ["id":"\(userId)","getby":"owner"]
            
        case .Event:
            return ["id":"\(userId)","getby":"user"]
            
        default:
            break;
        }
        return ["userid":"\(userId)"]
    }
    
    override func onSuccesfulRequset(dataRequest:Int , parameter:[String : AnyObject]? = nil, data:AnyObject){
        let infoRequest = PersonInfoRequestType(rawValue: dataRequest)!
        
        switch (infoRequest) {
        case .BasicInfo:
            // print(data)
            if let d = Mapper<PersonBasicData>().map(data){
                person.basicInfo  = d
                person.basicInfo.userid = userId
            }
            fetchData(PersonInfoRequestType.Profile.rawValue, completionHandler: nil)
            
            break;
        case .Views:
            // print(data)
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
            person.reviewsListManager.updateEntries(list)
            
            break
        case .Profile:
            if let d = Mapper<ProfileData>().map(data) {
                person.profileData  = d
                person.profileData.takeDataFromBasicInfo(person.basicInfo)
                EventUtils.postNotification(EventUtils.basicInfoUpdateKey)
                
            }
            break
            
        case .SentimentTimeLine:
            let array = JSON(data)
            var list = [SentimentTimelineData]()
            for (_,obj) in array {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<SentimentTimelineData>().map(finalString) {
                        list.append(view)
                    }
                }
            }
            
            if let p = parameter {
                let index = p["index"] as! Int
                
                person.sentimentTimeLineListManager[index].updateEntries(list)
            }
            break;
            
        case .ReviewAnalysis:
            // print(data)
            let array = JSON(data)
            var list = [ReviewAnalyticsData]()
            for (_,obj) in array {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<ReviewAnalyticsData>().map(finalString) {
                        
                        list.append(view)
                    }
                }
            }
            
            if let p = parameter {
                let index = p["index"] as! Int
                let filter = p["filter"] as!Int
                person.reviewAnalysisListManager[index][filter].updateEntries(list)
            }
            
            break
            
        case .Work:
            let workArray = JSON(data)
            var list = [MyWorkData]()
            for (_,obj) in workArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<MyWorkData>().map(finalString) {
                        list.append(view)
                    }
                }
            }
            person.worksListManager.updateEntries(list)
            break
            
        case .Event:
            let eventArray = JSON(data)
            var list = [EventData]()
            for (_,obj) in eventArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<EventData>().map(finalString) {
                        list.append(view)
                    }
                }
            }
            person.eventsListManager.updateEntries(list)
            break

            
        default:
            break;
        }
        
    }
    
    override func fetchListData(dataRequest: Int, parameter: [String : AnyObject], completionHandler: ServerRequestCallback?) {
        
        // let infoRequest = IssueInfoRequestType(rawValue: dataRequest)!
        var tab = 0
        if let t = parameter["tab"] as? Int {
            tab = t
        }
        // let index = parameter["index"] as! Int
        
        
        
        let lists =  person.getList(dataRequest,index: tab)
        
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
