//
//  ServerRequestInitiater.swift
//  MyVoice
//
//  Created by PB014 on 14/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias ServerRequestCallback = (ServerResult) -> Void

enum ServerResult{
    case Success(AnyObject?);
    case Failure(NSError?)
    case EveryThingUpdated
    case UnderProgress
}


class ServerRequestInitiater {
    
    
    static let i:ServerRequestInitiater = ServerRequestInitiater()
    
    private init (){
        
    }
    
    
    typealias ServerRequestInitiaterCallback = (status : Int, forTextField : UITextField)->()
    
    
    func valideUser(parameters:[String:AnyObject]){
        Alamofire.request(.POST,ServerUrls.validateUserUrl, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseString { (response) -> Void in
            print(response)
            print(response.result.isSuccess)
        }
    }
    
    func addUser(parameters:[String:AnyObject]){
        //print(parameters["json"])
        
        Alamofire.request(.POST,ServerUrls.addUserUrl, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseString { (response) -> Void in
            print(response)
            print(response.request)
            print(response.result.isSuccess)
        }
    }
    func getUserDetail(parameters:[String:AnyObject]){
        
        Alamofire.request(.POST,ServerUrls.getUserDetailsUrl, parameters: parameters, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON { (response) -> Void in
            // print(response.request!)
            // print(response.response!)
            if let json = response.result.value {
                // print("json data here")
                // print(json)
            }
        }
        
        
        //        Alamofire.request(.POST,ServerUrls.userDetailsUrl, parameters: ["userid":"1"], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).response { (response) -> Void in
        //           // print(response.2)
        //            if let statusesArray = try? NSJSONSerialization.JSONObjectWithData(response.2!, options: .AllowFragments) as? [String: AnyObject]{
        //                print("json data here")
        //
        //                print(statusesArray)                    // Finally we got the username
        //            }
        //
        //        }
    }
    
    func postMessageToServerForJsonResponse(url:String, postData:[String:AnyObject]?, completionHandler: ServerRequestCallback) {
        
        //  print(postData["json"]!)
        
        Alamofire.request(.POST,url, parameters: postData, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON { (response) -> Void in
            // print(response.response)
            
            if response.result.isSuccess {
                completionHandler(.Success(response.result.value))
                
            }
            else if response.result.isFailure  {
                print(response.request!)
                
                completionHandler(.Failure(response.result.error))
                
            }
            
            
            if let _ = response.result.value {
                //   print("data is \(json)")
            }
        }
        
        //        Alamofire.request(.POST,url, parameters: postData, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).response { (response) -> Void in
        //
        //            let readableContent = NSString(data: response.2!, encoding: NSUTF8StringEncoding)
        //            print("normal response.........\(readableContent)...")
        //            if let statusesArray = try? NSJSONSerialization.JSONObjectWithData(response.2!, options: .AllowFragments) as? [String: AnyObject]{
        //                print("json data here")
        //
        //                print(statusesArray)                    // Finally we got the username
        //            }
        //
        //        }
        
    }
    
    
    func postMessageToServerForStringResponse(url:String, postData:[String:AnyObject]?, completionHandler: ServerRequestCallback) {
        
        //  print(postData["json"]!)
        
        Alamofire.request(.POST,url, parameters: postData, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseString(completionHandler: { (response) -> Void in
            // print(response.response)
            
            if response.result.isSuccess {
                completionHandler(.Success(response.result.value))
                
            }
            else if response.result.isFailure  {
                print(response.request!)
                completionHandler(.Failure(response.result.error))
                
            }
        })

    }
    
    
    
    func initiateServerRequest(req:ServerRequest){
        
        switch req.responseType {
        case .Json:
            Alamofire.request(req.postType, req.url, parameters: req.postData, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON { (response) -> Void in
                // print(response.response)
                // print(response.data)
                if response.result.isSuccess {
                    if let cH = req.completionHandler {
                        cH(.Success(response.result.value))
                    }
                    
                }
                else if response.result.isFailure  {
                    if req.retryCount > 0 {
                        print("retry......!!!!!!!!")
                        req.retryCount-=1
                        
                        MyUtils.delay(req.intervalBetweenRetry, work: { () -> () in
                            self.initiateServerRequest(req)
                        })
                    }
                    else{
                        print(response.request!)
                        
                        if let cH = req.completionHandler {
                            cH(.Failure(response.result.error))
                        }
                    }
                }
            }
            
            //                if let json = response.result.value {
            //                    print("data is \(json)")
            //                }
            
            break;
        case .Normal:
            Alamofire.request(req.postType, req.url, parameters: req.postData, encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseString(completionHandler: { (response) -> Void in
                print(response.result)
                
                if response.result.isSuccess {
                    if let cH = req.completionHandler {
                        cH(.Success(response.result.value))
                    }
                    
                }
                else if response.result.isFailure  {
                    if req.retryCount > 0 {
                        print("retry......!!!!!!!!")
                        req.retryCount-=1
                        
                        MyUtils.delay(req.intervalBetweenRetry, work: { () -> () in
                            self.initiateServerRequest(req)
                        })
                    }
                    else{
                        print(response.request!)
                        
                        if let cH = req.completionHandler {
                            cH(.Failure(response.result.error))
                        }
                    }
                }
            })
            
            break
        }
        
    }
    
}

class ServerRequest{
    var url:String!
    var postData:[String:AnyObject]!
    var completionHandler:ServerRequestCallback?
    var postType:Alamofire.Method = .POST
    var responseType:ServerResponseType = .Json
    var retryCount = 1
    var intervalBetweenRetry = 2.0
    
    init(url:String, postData:[String:AnyObject], completionHandler: ServerRequestCallback){
        self.url = url
        self.postData = postData
        self.completionHandler = completionHandler
    }
}


enum ServerResponseType{
    case Normal;
    case Json
}