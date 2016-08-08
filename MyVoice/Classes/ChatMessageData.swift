//
//  ChatMessage.swift
//  MyVoice
//
//  Created by PB014 on 07/07/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ChatMessageData: Mappable {
    dynamic var id:String?
    
    
     init() {
    }
    
    required init?(_ map: Map) {
        // fatalError("init has not been implemented")
    }
    
    func mapping(map: Map) {
      
    }
    
}