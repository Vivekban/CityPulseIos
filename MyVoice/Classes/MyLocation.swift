//
//  MyLocation.swift
//  MyVoice
//
//  Created by PB014 on 25/05/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper

class MyLocation : Mappable {
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var city:String = ""
    var name = ""
    var country = ""
    var address = ""
    var postalCode = ""
    var administrativeArea = ""
    var subAdministrativeArea = ""
    var locality = ""
    var subLocality = ""
    var thoroughfare = ""
    var subThoroughfare = ""
    var region = ""
    var timeZone = ""
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["I_name"]
        country <- map["country"]
        address <- map["address"]
        postalCode <- map["postalcode"]
        administrativeArea <- map["admin_area"]
        subAdministrativeArea <- map["subadmin_area"]
        locality <- map["locality"]
        subLocality <- map["sublocality"]
        thoroughfare <- map["thoroughfare"]
        subThoroughfare <- map["subthoroughfare"]
        region <- map["region"]
        timeZone <- map["timezone"]
    }
    
}
