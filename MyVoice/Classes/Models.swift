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

class MeData{
    var basicInfo:PersonBasicData = PersonBasicData()
    var profileData:ProfileData = ProfileData()
    var viewsListManager:ServerDataList!
    var worksListManager:ServerDataList!
    var eventsListManager:ServerDataList!
    var videosListManager:ServerDataList!
    var reviewsListManager:ServerDataList!
 
    var creditsListManager:ServerDataList!
    var donationsListManager:ServerDataList!
    var pageViewListManager:ServerDataList!
    var badgesListManager:[ServerDataList] = [ServerDataList]()

    // for 3 differnt tabs
    var sentimentTimeLineListManager:[ServerDataList] = [ServerDataList]()
    //  filter and 3 tabs and for 5 different review types
    var reviewAnalysisListManager:[[ServerDataList]] = [[ServerDataList]]()

    init(){
        
        viewsListManager = ServerDataList(entries: [MyViewData]())
        worksListManager = ServerDataList(entries: [MyWorkData]())
        eventsListManager = ServerDataList(entries: [EventData]())
        videosListManager = ServerDataList(entries: [MyVideo]())
        reviewsListManager = ServerDataList(entries: [ReviewData]())
        
        // activity datas......
        creditsListManager = ServerDataList(entries: [CreditsData]())
        donationsListManager = ServerDataList(entries: [DonationData]())
        pageViewListManager = ServerDataList(entries: [SentimentTimelineData]())
        
        for _ in 0...1 {  // earned ... and to be earned
            badgesListManager.append(ServerDataList(entries: [BadgesData]()))
        }

//        for i in 1...2 {
//            let dummyWork = MyWorkData()
//            dummyWork.description = "Description of work \(i)"
//            dummyWork.title = "Title of work \(i)"
//            worksListManager.entries.append(dummyWork)
//        }
        
        for i in 1...2 {
            let dummyEvent = EventData()
            dummyEvent.owner = CurrentSession.i.userId
            dummyEvent.website = "www.playbuff.com"
            dummyEvent.startTime = TimeDateUtils.getStringFrom(NSDate(), mode: UIDatePickerMode.DateAndTime);
            dummyEvent.endTime = TimeDateUtils.getStringFrom(NSDate(), mode: UIDatePickerMode.DateAndTime);
            dummyEvent.description = "Description of event...... \(i)..\nSecond line and finally \nThird line\n forth line\nfith line"
            dummyEvent.title = "Title of event \(i)"
            eventsListManager.entries.append(dummyEvent)
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
    
    func getList(request : Int, index :Int = 0) -> ServerDataList{
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
        case PersonInfoRequestType.Credits.rawValue:
            return creditsListManager
        case PersonInfoRequestType.Donations.rawValue:
            return donationsListManager
        case PersonInfoRequestType.Badges.rawValue:
            return badgesListManager[index]
        case PersonInfoRequestType.PageView.rawValue:
            return pageViewListManager
        case PersonInfoRequestType.SentimentTimeLine.rawValue:
            return sentimentTimeLineListManager[index]
        default :
            // assertionFailure("unknown request")
            return viewsListManager
        }
    }

}

class HomeDataList {
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
        
        var dummyPolls = [PollData]()
        
        for i in 0...2 {
            let pol = PollData()
            pol.title = "This is question of poll \(i).\n here comes next line "
            pol.category = "Educaiton"
            dummyPolls.append(pol)
        }
        
        pollsListsManager[0].updateEntries(dummyPolls, isClear: true)
        
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

