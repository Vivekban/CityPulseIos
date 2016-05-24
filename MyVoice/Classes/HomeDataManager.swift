//
//  HomeDataManager.swift
//  MyVoice
//
//  Created by PB014 on 05/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation



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


enum IssueInfoRequestType:Int{
    
    case Normal = 0, Popular, Relevant, Subscribed,Resolved,Own
}




class HomeDataManager: ServerDataManager{
   
    var homeDataLists = HomeDataList()
    var issueCategorises:[String] = [String]()
    override init(){
        super.init()
 //        MyUtils.delay(0.01) { () -> () in
 //            self.fetchIssueInfo(.Normal, completionHandler: nil)
 //        }
        // fetchData(IssueInfoRequestType.Normal.rawValue, completionHandler: nil)
        
        
    }
    
    
//    func fetchIssueInfo(infoRequest:IssueInfoRequestType , completionHandler:ServerRequestCallback?){
//        let uInfoRequest = ServerRequest(url: getUrlBasedOnRequest(infoRequest), postData: getParamterBasedOnRequest(infoRequest)) { [weak self](result) -> Void in
//            // process request
//            print(result)
//            switch result {
//            case .Success(let data):
//                if let d = data {
//                    if let dis = self {
//                        dis.onSuccesfulRequset(infoRequest, data: d)
//                    }
//                }
//                break
//            case .Failure(let error):
//                print(error)
//                
//            }
//            // tell request originator
//            if let cH = completionHandler {
//                cH(result)
//            }
//        }
//        ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
//    }
    
    override func getUrlBasedOnRequest(dataRequest:Int) -> String{
        let infoRequest = IssueInfoRequestType(rawValue: dataRequest)!
        switch (infoRequest) {
        case .Normal:
            return ServerUrls.getIssueListByStatus
        case .Popular:
            return ServerUrls.getIssueDetails
        case .Relevant:
            return ServerUrls.getIssueDetails
        case .Subscribed:
            return ServerUrls.getSubscribedIssueUrl
        case .Resolved:
            return ServerUrls.getIssueByOwnerUrl
        case .Own:
            return ServerUrls.getIssueByOwnerUrl
        default:
            break;
        }
        return ""
    }
    
    override func getParamterBasedOnRequest(dataRequest:Int, parameter:[String : AnyObject]? = nil) -> [String : AnyObject]{

        let infoRequest = IssueInfoRequestType(rawValue: dataRequest)!

        switch (infoRequest) {
        case .Normal:
            return ["status":"n"]//["status":"O"]
        case .Popular:
            return ["getBy":"popular"]
        case .Relevant:
            return ["getBy":"relevant"]
        case .Subscribed:
            return ["userid":CurrentSession.i.userId]
        case .Resolved:
            return ["status":"o"]
        case .Own:
            return ["owner":CurrentSession.i.userId]
        default:
            break;
        }
        return ["owner":CurrentSession.i.userId]
    }

    
    override func onSuccesfulRequset(dataRequest:Int , parameter:[String : AnyObject]? = nil, data:AnyObject){
        
        
        if let param = parameter{
            let infoRequest = IssueInfoRequestType(rawValue: dataRequest)!
            let tab = param["tab"] as! Int
            let index = param["index"] as! Int

            var entities : [BaseData]!

        
        switch (tab) {
        case 0,1:
            print(data)
            let viewArray = JSON(data)
            entities = [IssueData]()
            for (_,obj) in viewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<IssueData>().map(finalString) {
                        entities.append(view)
                    }
                }
            }
            
            if tab == 0 {
                homeDataLists.issueListsManager[index].updateEntries(entities)
            }
            else{
                homeDataLists.hoaIssueListsManager[index].updateEntries(entities)
            }
            
            break
        case 2:
            print(data)
            let viewArray = JSON(data)
            entities = [PollData]()
            for (_,obj) in viewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<PollData>().map(finalString) {
                        entities.append(view)
                    }
                }
            }
            homeDataLists.pollsListsManager[index].updateEntries(entities)
           break

        default:
            break;
        }
            
         }
        
        // person.basicInfo  = Mapper<PersonBasicData>().map(data)
        
    }
    
    
    override func fetchListData(dataRequest: Int, parameter: [String : AnyObject], completionHandler: ServerRequestCallback?) {
        
        // let infoRequest = IssueInfoRequestType(rawValue: dataRequest)!
            let tab = parameter["tab"] as! Int
            let index = parameter["index"] as! Int
        
        
        
        let lists =  homeDataLists.getList(tab)
        
        if lists[index].hasAllEntries {
            if let handler = completionHandler {
                handler(ServerResult.EveryThingUpdated)
                return
            }
        }
        
        if lists[index].isFetching {
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
