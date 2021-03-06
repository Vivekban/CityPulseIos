//
//  ServerDataList.swift
//  MyVoice
//
//  Created by PB014 on 12/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation

class ServerDataList {
    
    //var serverRequest : ServerRequestInitiater?
    
    var lastUpdated : NSDate?
    var entries : [BaseData]!
    var hasAllEntries = false
    
    var startItemIdex = 0
    var lastItemIndex = 0
    
    
    var isFetching = false
    
    
    
    init( entries : [BaseData]){
        self.entries = entries
    }
    
    
    
    
    func fetchMoreEntriesIfPossible(count : Int = 10) -> Bool {
        if hasAllEntries {
            return false
        }
        
        isFetching = true
        
        
        //fetchMoreEntries(count)
        
        return true
        
    }
    
    func updateEntries(entries : [BaseData], isClear : Bool = false){
        if isClear {
            self.entries.removeAll()
        }

        for e in entries {
            if !isContainEntry(e) {
                self.entries.append(e)
            }
        }
        
        //print("final entry. count....\(entries.count).....");
        
        lastUpdated = NSDate()
        
        isFetching = false
        
    }
    
    
    func isContainEntry(e : BaseData) -> Bool {
        let val = e.hashValue
        for i in entries {
            if ( i.hashValue == val){
                return true
            }
        }
        return false
    }
    
    
}
