//
//  AppDataController.swift
//  MyVoice
//
//  Created by PB014 on 16/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import SwiftyJSON


enum AppDataRequest :Int {
    case Category = 0, MarkTo
}

class AppDataController : ServerDataManager{
    var appData = AppData()

    override init(){
        super.init()
        fetchData(0, completionHandler: nil)
        fetchData(1, completionHandler: nil)

    }
    
    override func getUrlBasedOnRequest(dataRequest: Int) -> String {
        switch (dataRequest) {
        case AppDataRequest.Category.rawValue:
            return ServerUrls.appDataUrl
        case AppDataRequest.MarkTo.rawValue:
            return ServerUrls.getMarkToList
        default:
            break;
        }
        return ServerUrls.appDataUrl
    }
    
    override func getParamterBasedOnRequest(dataRequest: Int, parameter: [String : AnyObject]?) -> [String : AnyObject] {
        return["":""]
    }
    
    override func onSuccesfulRequset(dataRequest: Int, parameter: [String : AnyObject]?, data: AnyObject) {
        let json = JSON(data)
        
        switch (dataRequest) {
        case AppDataRequest.Category.rawValue:
            for (_,j) in json {
                print(j)
                // if  let cat = j as? String {
                appData.categories.append(j.stringValue)
                //  }
            }
        case AppDataRequest.MarkTo.rawValue:
            for (_,j) in json {
                print(j)
                   let values = j.stringValue.componentsSeparatedByString("~")
                    let id = values[values.count - 1]
                    print(id)
                    appData.markTo.append(BaseFilter(index: Int(id) ?? 0, value: values[0], dataRequest: 0))
                
            }
        default:
            break;
        }

        
       
        // print(data)
    }
    
}