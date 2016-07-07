//
//  PublicFigureDataManager.swift
//  MyVoice
//
//  Created by PB014 on 24/05/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

enum PublicFigureDataRequestType:Int{
    
    case Top = 0, My , Official
}

class PublicFigureDataManager : ServerDataManager {
    
    var leadearsLists = [ServerDataList]()
    
    override init(){
        
        for _ in 0...2{
            leadearsLists.append(ServerDataList(entries: [ProfileData]()))
        }
        
    }
    
    override func getUrlBasedOnRequest(dataRequest:Int) -> String{
        let infoRequest = PublicFigureDataRequestType(rawValue: dataRequest)!
        switch (infoRequest) {
        case .Top:
            return ServerUrls.getTopCommunityLeaderUrl
        case .My:
            return ServerUrls.getMyCommunityLeaderUrl
        case .Official:
            return ServerUrls.getOfficialsUrl

        default:
            break;
        }
        return ""
    }
    
    override func getParamterBasedOnRequest(dataRequest:Int, parameter:[String : AnyObject]? = nil) -> [String : AnyObject]{
        
        let infoRequest = PublicFigureDataRequestType(rawValue: dataRequest)!
        
        switch (infoRequest) {
    
        case .Top:
            return ["userid":CurrentSession.i.userId]
        case .My:
            return ["userid":CurrentSession.i.userId]
        default:
            return ["userid":CurrentSession.i.userId]
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
                entities = [ProfileData]()
                for (_,obj) in viewArray {
                    if let finalString = obj.rawString() {
                        // print(" value is \(i)...+....\(finalString)")
                        if let view = Mapper<ProfileData>().map(finalString) {
                            entities.append(view)
                        }
                    }
                }
                
                leadearsLists[tab].updateEntries(entities)
                
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
        
        
        
        let lists =  leadearsLists[tab]
        
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