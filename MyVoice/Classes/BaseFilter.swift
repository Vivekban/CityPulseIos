//
//  BaseFilter.swift
//  MyVoice
//
//  Created by PB014 on 11/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit



class BaseFilter {
    var index:Int = 0
    var value:String!
    var dataRequestType = 0
    init (index:Int , value:String ,dataRequest :Int){
        self.index = index
        self.value = value
        self.dataRequestType = dataRequest
    }
    
   static  func getFilterValues(filters: [BaseFilter]) -> [String]{
        var values = [String]()
        for filter in filters {
            values.append(filter.value)
        }
        return values
    }
    
    static  func getFilterOfString(value:String,filters: [BaseFilter]) -> BaseFilter?{

        for filter in filters {
            if filter.value == value{
                return filter
            }
        }
        
        return nil
    }

}


class HomeFilter : BaseFilter{

}