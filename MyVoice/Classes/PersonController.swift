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
    
    case BasicInfo = 1, Views, Reviews
}

class PersonController {
    var person:Person!
    var userId:Int!
    
    init(userID:Int){
        self.userId = userID
        // CurrentSession.i.userId = userID
        person = Person()
       // getUserViews(nil)
       // getUserInfo(nil)
        fetchUserInfo(.BasicInfo, completionHandler: nil)
        fetchUserInfo(.Views, completionHandler: nil)

    }
    
    
    func fetchUserInfo(infoRequest:PersonInfoRequestType , completionHandler:ServerRequestCallback?){
        let uInfoRequest = ServerRequest(url: getUrlBasedOnUserInfoRequest(infoRequest), postData: ["userid":"\(userId)"]) { [weak self](result) -> Void in
            // process request
            switch result {
            case .Success(let data):
        
                if let d = data {
                    if let dis = self {
                        dis.onSuccesfulRequset(infoRequest, data: d)
                    }
                }
                break
            case .Failure(let error):
                print(error)
                
            }
            
            // tell request originator
            if let cH = completionHandler {
                cH(result)
            }
        }
        ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
    }
    
    func getUrlBasedOnUserInfoRequest(infoRequest:PersonInfoRequestType) -> String{
        switch (infoRequest) {
        case .BasicInfo:
            return ServerUrls.getUserDetailsUrl
        case .Reviews:
            return ServerUrls.getReviewByOwnerUrl
        case .Views:
            return ServerUrls.getViewByUserIdUrl
        default:
            break;
        }
    }
    
    func onSuccesfulRequset(infoRequest:PersonInfoRequestType , data:AnyObject){
        
        switch (infoRequest) {
        case .BasicInfo:
            //print(data)
            person.basicInfo  = Mapper<PersonBasicData>().map(data)!
            person.basicInfo.userid = userId
            break;
        case .Views:
            let viewArray = JSON(data)
            person.views.removeAll()
            for (i,obj) in viewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<MyViewData>().map(finalString) {
                        person.views.append(view)
                    }
                }
            }
        default:
            break;
        }
        
       
        // person.basicInfo  = Mapper<PersonBasicData>().map(data)
        
    }
    
    
//    func getUserInfo(completionHandler:ServerRequestCallback?){
//        let uInfoRequest = ServerRequest(url: ServerUrls.getUserDetailsUrl, postData: ["userid":"\(userId)"]) { [weak self](result) -> Void in
//            
//            if let cH = completionHandler {
//                cH(result)
//            }
//            
//            switch result {
//            case .Success(let data):
//                if let d = data {
//                    
//                }
//                break
//            case .Failure(let error):
//                print(error)
//                
//            }
//        }
//        ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
//        
//        
//    }
    
//    func getUserViews(completionHandler:ServerRequestCallback?){
//        let uInfoRequest = ServerRequest(url: , postData: ["userid":"\(userId)"]) { [weak self](result) -> Void in
//            
//            if let cH = completionHandler {
//                cH(result)
//            }
//            
//            switch result {
//            case .Success(let data):
//                if let d = data {
//                    // print(d)
//                    
//                    let viewArray = JSON(d)
//                    self.person.views.removeAll()
//                    for (i,obj) in viewArray {
//                        if let finalString = obj.rawString() {
//                            // print(" value is \(i)...+....\(finalString)")
//                            if let view = Mapper<MyViewData>().map(finalString) {
//                                self.person.views.append(view)
//                            }
//                        }
//                    }
//                    // person.basicInfo  = Mapper<PersonBasicData>().map(data)
//                    
//                    
//                }
//                break
//            case .Failure(let error):
//                print(error)
//                
//            }
//        }
//        ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
//    }
    
}
