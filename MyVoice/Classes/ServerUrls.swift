//
//  ServerUrls.swift
//  MyVoice
//
//  Created by PB014 on 14/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation

class ServerUrls {
    //TODO: remove key from here
                static let watsonApiKey = "0f24d1f20bcfb5ce4f9261d1fd989de74ff3387a"

    
    
    static let baseUrl = "http://www.myvoice.elasticbeanstalk.com"
    
    // MARK: User
    static let validateUserUrl = baseUrl + "/ValidateUser"
    static let addUserUrl = baseUrl + "/AddUser"
    static let getUserDetailsUrl = baseUrl + "/UserDetail"
    static let updateUserDetailsUrl = baseUrl + "/EditUser"

    // MARK: REVIEW
    static let addReviewUrl = baseUrl + "/AddReview"
    static let getReviewByIdUrl = baseUrl + "/GetReviewById"
    static let getReviewByOwnerUrl = baseUrl + "/GetReviewByOwner"
    
    
    // MARK: VIEW
    static let addViewUrl = baseUrl + "/AddView"
    static let updateViewUrl = baseUrl + "/UpdateView"
    static let getViewByIdUrl = baseUrl + "/GetViewById"
    static let getViewByUserIdUrl = baseUrl + "/GetViewByUser"
    
    //MARK: ISSUE
    
    static let addIssueUrl = baseUrl + "/SubmitIssue"
    static let updateIssueUrl = baseUrl + "/UpdateIssue"
    static let getIssueByIdUrl = baseUrl + "/GetIssueById"
    static let getIssueByMarkToUrl = baseUrl + "/GetIssueByMarkTo"
    static let getIssueByOwnerUrl = baseUrl + "/GetIssueByOwner"
    
    // MARK: - event
    
       static let addEventUrl = baseUrl + "/AddEvent/"
       static let updateEventUrl = baseUrl + "/UpdateEvet"
       static let getEventByIdUrl = baseUrl + "/GetEventById"

    // MARK: - work
    
    static let addWorkUrl = baseUrl + "/AddWork/"
    static let updateWorkUrl = baseUrl + "/UpdateWork"
    static let getWorkByIdUrl = baseUrl + "/GetWorkById"
    
    
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"

    
    // MARK: - WATSON URLS
    static let watsonBaseUrl = "http://gateway-a.watsonplatform.net/"
    
    static let getKeywordsUrl = watsonBaseUrl + "calls/text/TextGetRankedKeywords"
    
    static let getEntityUrl = "http://access.alchemyapi.com/calls/text/TextGetRankedNamedEntities"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    //    static let Url = baseUrl + "/ADS"
    
    
    
//        {
//            "credentials": {
//                "url": "https://gateway-a.watsonplatform.net/calls",
//                "note": "It may take up to 5 minutes for this key to become active"
//            }
//    }
//    
}
 