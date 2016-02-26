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
    var viewsListManager:ServerDataList!
    var worksListManager:ServerDataList!
    var eventsListManager:ServerDataList!
    var videosListManager:ServerDataList!
    var reviewsListManager:ServerDataList!
    
    // for 3 differnt tabs
    var sentimentTimeLineListManager:[ServerDataList] = [ServerDataList]()
    //  filter and 3 tabs and for 5 different
    var reviewAnalysisListManager:[[ServerDataList]] = [[ServerDataList]]()

    init(){
        
        viewsListManager = ServerDataList(entries: [MyViewData]())
        worksListManager = ServerDataList(entries: [MyWorkData]())
        eventsListManager = ServerDataList(entries: [EventData]())
        videosListManager = ServerDataList(entries: [MyVideo]())
        reviewsListManager = ServerDataList(entries: [ReviewData]())
        
        for i in 1...2 {
            let dummyWork = MyWorkData()
            dummyWork.description = "Description of work \(i)"
            dummyWork.title = "Title of work \(i)"
            worksListManager.entries.append(dummyWork)
        }
        
        for _ in 0...2 {
            let list1 = ServerDataList(entries: [SentimentTimelineData]())
           
            var list2 = [ServerDataList]()
            
            for _ in 0...4 {
             list2.append(ServerDataList(entries: [ReviewAnalyticsData]()))
            }
            
            sentimentTimeLineListManager.append(list1)
            reviewAnalysisListManager.append(list2)
        }
    }
    
    func getList(request : Int) -> ServerDataList{
        switch (request) {
        case  PersonInfoRequestType.Views.rawValue:
            return viewsListManager
        case  PersonInfoRequestType.Work.rawValue:
            return worksListManager
        case  PersonInfoRequestType.Event.rawValue:
            return eventsListManager
        case  PersonInfoRequestType.Video.rawValue:
            return videosListManager
        case  PersonInfoRequestType.Reviews.rawValue:
            return reviewsListManager
        default :
            return viewsListManager
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


class AppData {
    var categories = [String]()
    var markTo = [BaseFilter]()
    init(){
        
    }
}

