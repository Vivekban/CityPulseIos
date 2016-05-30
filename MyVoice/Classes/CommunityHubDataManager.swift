//
//  CommunityHubDataManager.swift
//  MyVoice
//
//  Created by PB014 on 26/05/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import SwiftyJSON

enum CommunityHubDataRequestType:Int{
    
    case MyCommunity = 0,TopCommunity, TopMember, SearchResult
}

class CommunityHubDataManager : ServerDataManager {
    
    var lists = [ServerDataList]()
    
    override init(){
        
        for _ in 0...3{
            lists.append(ServerDataList(entries: [CommunityItemData]()))
        }
        
    }
    
    override func getUrlBasedOnRequest(dataRequest:Int) -> String{
        let infoRequest = CommunityHubDataRequestType(rawValue: dataRequest)!
        switch (infoRequest) {
        case .MyCommunity:
            return ServerUrls.getTopCommunityLeaderUrl
        case .TopCommunity:
            return ServerUrls.getMyCommunityLeaderUrl
        case .TopMember:
            return ServerUrls.getMyCommunityLeaderUrl
        case .SearchResult:
            return ServerUrls.getMyCommunityLeaderUrl
        default:
            break;
        }
        return ""
    }
    
    override func getParamterBasedOnRequest(dataRequest:Int, parameter:[String : AnyObject]? = nil) -> [String : AnyObject]{
        
        let infoRequest = CommunityHubDataRequestType(rawValue: dataRequest)!
        
        switch (infoRequest) {
            
        case .MyCommunity:
            return ["userid":CurrentSession.i.userId]
        case .TopCommunity:
            return ["userid":CurrentSession.i.userId]
        case .TopMember:
            return ["userid":CurrentSession.i.userId]
        case .SearchResult:
            return ["userid":CurrentSession.i.userId]
        default:
            break;
        }
        return ["owner":"O"]
    }
    
    
    override func onSuccesfulRequset(dataRequest:Int , parameter:[String : AnyObject]? = nil, data:AnyObject){
        
        
        if let param = parameter{
            let tab = param["tab"] as! Int
            let index = param["index"] as! Int
            
            var entities : [BaseData]!
            
            
            switch (tab) {
            case 0,1:
                print(data)
                let viewArray = JSON(data)
                entities = [CommunityItemData]()
                for (_,obj) in viewArray {
                    if let finalString = obj.rawString() {
                        // print(" value is \(i)...+....\(finalString)")
                        if let view = Mapper<CommunityItemData>().map(finalString) {
                            entities.append(view)
                        }
                    }
                }
                
                lists[tab].updateEntries(entities)
                
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
        
        
        
        let list =  lists[tab]
        
        if list.hasAllEntries {
            if let handler = completionHandler {
                handler(ServerResult.EveryThingUpdated)
                return
            }
        }
        
        if list.isFetching {
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