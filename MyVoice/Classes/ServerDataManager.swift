//
//  File.swift
//  MyVoice
//
//  Created by PB014 on 13/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

/**
 
 This is abstract class handle the request to fetch data form server and save it too . It is middle man between view controller and server
 
 check HomeDataManager / PersonController
 
 */


class ServerDataManager : NSObject {
    
    override init(){
        
    }
    
    func fetchData(dataRequest:Int ,parameter: [String:AnyObject]? = nil , completionHandler:ServerRequestCallback?){
        
        //let t = convertRawValueToGenric(dataRequest)
        if parameter == nil {
            postRequest(dataRequest, url: getUrlBasedOnRequest(dataRequest), params: getParamterBasedOnRequest(dataRequest), completionHandler: completionHandler)
        }
        else{
            fetchListData(dataRequest, parameter: parameter!, completionHandler: completionHandler)
        }
        
    }
    
    func fetchListData(dataRequest:Int ,parameter: [String:AnyObject] , completionHandler:ServerRequestCallback?){
        print(parameter)
        postRequest(dataRequest, url: getUrlBasedOnRequest(dataRequest), params: parameter, completionHandler: completionHandler)
    }
    
    
    func postRequest(dataRequest:Int,url :String, params : [String : AnyObject],completionHandler:ServerRequestCallback?) {
        print(params)
 
        let uInfoRequest = ServerRequest(url: url, postData: params) { [weak self](result) -> Void in
            // process request
            print(result)
            print(params)
            switch result {
            case .Success(let data):
                if let d = data {
                    if let dis = self {
                        dis.onSuccesfulRequset(dataRequest,parameter: params,data: d)
                    }
                }
                break
            case .Failure(let error):
                print(error)
                self?.onFailure(error)
            default :
                break
            }
            // tell request originator
            if let cH = completionHandler {
                cH(result)
            }
        }
        ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
        
    }

    
    func getUrlBasedOnRequest(dataRequest:Int) -> String{
        return ""
    }
    
    func getParamterBasedOnRequest(dataRequest:Int, parameter:[String : AnyObject]? = nil) -> [String : AnyObject]{
        return ["owner":"O"]
    }
    
    
    func onSuccesfulRequset(dataRequest:Int, parameter:[String : AnyObject]? = nil, data:AnyObject){
        
    }
    
    func onFailure(error :NSError?){
        
    }
    
}


