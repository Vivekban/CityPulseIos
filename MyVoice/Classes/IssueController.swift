//
//  IssueController.swift
//  MyVoice
//
//  Created by PB014 on 05/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation



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


enum IssueInfoRequestType:Int{
    
    case Normal = 0, Popular, Relevant, Subscribed, Resolved
}

class IssueController {
    var issueLists: [[IssueData]] = [[IssueData]]()
    
    init(){
        
        for _ in 0...4{
            issueLists.append([IssueData]())
        }
        
        MyUtils.delay(0.01) { () -> () in
            self.fetchIssueInfo(.Normal, completionHandler: nil)
        }
        
        // fetchIssueInfo(.Views, completionHandler: nil)
        
    }
    
    
    func fetchIssueInfo(infoRequest:IssueInfoRequestType , completionHandler:ServerRequestCallback?){
        let uInfoRequest = ServerRequest(url: getUrlBasedOnUserInfoRequest(infoRequest), postData: ["owner":"\(CurrentSession.i.userId)"]) { [weak self](result) -> Void in
            // process request
            print(result)
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
    
    func getUrlBasedOnUserInfoRequest(infoRequest:IssueInfoRequestType) -> String{
        switch (infoRequest) {
        case .Normal:
            return ServerUrls.getIssueByOwnerUrl
        case .Popular:
            return ServerUrls.getIssueByOwnerUrl
        case .Relevant:
            return ServerUrls.getIssueByOwnerUrl
        default:
            break;
        }
        return ""
    }
    
    func onSuccesfulRequset(infoRequest:IssueInfoRequestType , data:AnyObject){
        
        switch (infoRequest) {
        case .Normal,.Popular:
            print(data)
            let viewArray = JSON(data)
            var issues = issueLists[infoRequest.rawValue]
            issues.removeAll()
            for (_,obj) in viewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<IssueData>().map(finalString) {
                        issues.append(view)
                    }
                }
            }
            break
        default:
            break;
        }
        
        
        // person.basicInfo  = Mapper<PersonBasicData>().map(data)
        
    }
    
}
