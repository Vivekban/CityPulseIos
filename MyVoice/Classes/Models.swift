//
//  Person.swift
//  MyVoice
//
//  Created by PB014 on 14/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class PersonData{
    var basicInfo:PersonBasicData = PersonBasicData()
    var profileData:ProfileData = ProfileData()
    var views:[MyViewData] = [MyViewData]()
    var work:[MyWorkData] = [MyWorkData]()
    var event:[EventData] = [EventData]()
    var video:[MyVideo] = [MyVideo]()
    var reviews:[ReviewData] = [ReviewData]()
    
    init(){
        for i in 1...2 {
            let dummyWork = MyWorkData()
            dummyWork.description = "Description of work \(i)"
            dummyWork.title = "Title of work \(i)"
            work.append(dummyWork)
        }
    }
}

class IssuesList {
//    var issueLists: [[IssueData]] = [[IssueData]]()
//    var hoaIssueLists: [[IssueData]] = [[IssueData]]()
//    var pollsLists: [[IssueData]] = [[IssueData]]()
//    
    var issueListsManager = [ServerDataList]()
    var hoaIssueListsManager = [ServerDataList]()
    var pollsListsManager = [ServerDataList]()
    
    
     init(){
        for _ in 0...4{
            issueListsManager.append(ServerDataList(entries: [IssueData]()))
        }
        for _ in 0...4{
            hoaIssueListsManager.append(ServerDataList(entries: [IssueData]()))
        }
        for _ in 0...3{
            pollsListsManager.append(ServerDataList(entries: [PollData]()))
        }
    }
    
    
    func getList(tab : Int) -> [ServerDataList]{
        switch (tab) {
            
        case 0:
            return issueListsManager
        case 1:
            return hoaIssueListsManager
        case 2:
            return pollsListsManager
        default :
            return issueListsManager
        }
    }
    
    
}


