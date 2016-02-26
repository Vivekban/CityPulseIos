//
//  WatsonApiHelper.swift
//  MyVoice
//
//  Created by PB014 on 22/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import SwiftyJSON


class WatsonApiHelper {
    static let i = WatsonApiHelper()
    
    private init(){
        
    }
    
    private func getDefaultParams() -> [String:String] {
        var parameter:[String:String] = [String:String]()
        parameter["apikey"] = ServerUrls.watsonApiKey
        parameter["outputMode"] = "json"
        return parameter
    }
    
    func fetchTagsFromServer(text:String, completion:ServerRequestCallback){
        var parameter:[String:String] = getDefaultParams()
        
        parameter["text"] = text
        parameter["maxRetrieve"] = "10"
        parameter["keywordExtractMode"] = "normal"
        
        ServerRequestInitiater.i.postMessageToServerForJsonResponse(ServerUrls.getKeywordsUrl, postData: parameter) { [weak self] (result) -> Void in
            //  print(result)
            if self == nil {
                return
            }
            
            switch (result) {
            case .Success(let data):
                if let d = data {
                    let jsonData = JSON(d)
                    if (jsonData["status"] == "OK"){
                        
                        log.info("\(jsonData["keywords"])")
                        
                        let jsonKeywords = jsonData["keywords"].array
                        
                        
                        var words = 0
                        var tagString = ""
                        
                        for i in jsonKeywords!{
                            
                            log.info(" text is \( i["text"]) and relevance is \(i["relevance"])")
                            
                            if words < 6 {
                                tagString += "\(i["text"].string!), "
                                words++
                            }
                            else{
                                break;
                            }
                            
                        }
                        
                        completion(ServerResult.Success(tagString))
                    }
                    
                }
                break;
            default:
                completion(result)
                break;
            }
        }
    }
    
    
    func doToneAnalysisOf(text:String, completion:ServerRequestCallback){
        var parameter:[String:String] = getDefaultParams()
        
        parameter["text"] = text
        // parameter["maxRetrieve"] = "10"
        // parameter["keywordExtractMode"] = "normal"
        
        ServerRequestInitiater.i.postMessageToServerForJsonResponse(ServerUrls.getToneAnalysisUrl, postData: parameter) { [weak self] (result) -> Void in
            //  print(result)
            if self == nil {
                return
            }
            
            switch (result) {
            case .Success(let data):
                if let d = data {
                    let jsonData = JSON(d)
                    if (jsonData["status"] == "OK"){
                        
                        log.info("\(jsonData["keywords"])")
                        
                        let jsonKeywords = jsonData["keywords"].array
                        
                        
                        var words = 0
                        var tagString = ""
                        
                        for i in jsonKeywords!{
                            
                            log.info(" text is \( i["text"]) and relevance is \(i["relevance"])")
                            
                            if words < 6 {
                                tagString += "\(i["text"].string!), "
                                words++
                            }
                            else{
                                break;
                            }
                            
                        }
                        
                        completion(ServerResult.Success(tagString))
                    }
                    
                }
                break;
            default:
                completion(result)
                break;
            }
            
        }
        
        
    }

    
}