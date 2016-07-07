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
    
    
    
    static let baseUrl = "http://ec2-54-80-186-180.compute-1.amazonaws.com/MyVoice"
    
    // MARK: User
    static let validateUserUrl = baseUrl + "/ValidateUser"
    static let addUserUrl = baseUrl + "/AddUser"
    static let getUserDetailsUrl = baseUrl + "/UserDetail"
    static let getUserProfileDetailsUrl = baseUrl + "/GetUserCBDDetails"
    
    static let updateUserDetailsUrl = baseUrl + "/EditUser"
    
    // MARK: REVIEW
    static let addReviewUrl = baseUrl + "/WriteReview"
    static let getReviewByIdUrl = baseUrl + "/GetReviewById"
    static let getReviewByOwnerUrl = baseUrl + "/GetReviewByOwner"
    
    
    // MARK: VIEW
    static let addViewUrl = baseUrl + "/AddView"
    static let updateViewUrl = baseUrl + "/EditView"
    static let getViewByIdUrl = baseUrl + "/GetViewById"
    static let getViewByUserIdUrl = baseUrl + "/GetViewByUser"
    
    //MARK: ISSUE
    
    static let addIssueUrl = baseUrl + "/SubmitIssue"
    static let updateIssueUrl = baseUrl + "/UpdateIssue"
    static let getIssueByIdUrl = baseUrl + "/GetIssueById"
    static let getIssueByMarkToUrl = baseUrl + "/GetIssueByMarkTo"
    static let getIssueByOwnerUrl = baseUrl + "/GetIssueByOwner"
    static let getIssueListByStatus = baseUrl + "/GetIssueByStatus"
    static let getSubscribedIssueUrl = baseUrl + "/GetSubscribedIssue"
    static let getIssueDetails = baseUrl + "/GetIssueDetail"
    
    
    // MARK: - Poll
    static let addPollUrl = baseUrl + "/SubmitPoll"
    static let updatePollUrl = baseUrl + "/EditPoll"
    static let getPollsUrl = baseUrl + "/GetPollByUser"
    
    
    // MARK: - Issue Detail
    //static let Url = baseUrl + "/ADS"
    static let resposeIssueUrl = baseUrl + "/ResponseIssue"
    
    static let subscribeIssueUrl = baseUrl + "/SubscribeIssue"
    static let flagIssueUrl = baseUrl + "/"
    
    static let voteIssueUrl = baseUrl + "/VoteIssue"
    static let voteResponseUrl = baseUrl + "/VoteIssueResponse"
    
    
    static let voteIssueResponsUrl = baseUrl + "/VoteIssueResponse"
    
    static let GetIssueResponsesUrl = baseUrl + "/GetIssueResponses"
    
    static let GetIssueVotesUrl = baseUrl + "/GetIssueVotes"
    static let GetResponseVotesUrl = baseUrl + "/GetResponseVotes"
    
    
    
    // MARK: - event
    
    static let addEventUrl = baseUrl + "/SubmitEvent"
    static let updateEventUrl = baseUrl + "/EditEvent"
    static let getEventByIdUrl = baseUrl + "/GetEventByUser"
    
    // MARK: - work
    
    static let addWorkUrl = baseUrl + "/SubmitWork"
    static let updateWorkUrl = baseUrl + "/EditWork"
    static let getWorkUrl = baseUrl + "/GetWork"
    
    // MARK: - App related
    static let appDataUrl = baseUrl + "/CategoryList"
    static let getMarkToList = baseUrl + "/GetMarkToList"
    
    
    static let getSentimentTimelineUrl = baseUrl + "/GetSentimentData"
    static let getReviewAnalyticsUrl = baseUrl + "/GetAnalyticData"
    
    static let getTopCommunityLeaderUrl = baseUrl + "/ADS"
    static let getMyCommunityLeaderUrl = baseUrl + "/ADS"
    static let getOfficialsUrl = baseUrl + "/ADS"
    
    //    static let Url = baseUrl + "/ADS"
    
    
    // MARK: - WATSON URLS
    static let watsonBaseUrl = "http://gateway-a.watsonplatform.net/"
    
    static let getKeywordsUrl = watsonBaseUrl + "calls/text/TextGetRankedKeywords"
    
    static let getToneAnalysisUrl = "https://gateway.watsonplatform.net/tone-analyzer-beta/api/v3/tone"
    
    
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
    
    
    
    static let googleMapUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    static let apikey = "AIzaSyB_psfefaTWj4sEVtNljP8jFayYqbcNohc"
    
    
    
    //        {
    //            "credentials": {
    //                "url": "https://gateway-a.watsonplatform.net/calls",
    //                "note": "It may take up to 5 minutes for this key to become active"
    //            }
    //    }
    //
    
    
    //
    //    "credentials": {
    //    "url": "https://gateway.watsonplatform.net/tone-analyzer-beta/api",
    //    "username": "dcf7a887-ceba-4748-86eb-a63d15df3e68",
    //    "password": "Z5DFpbnruafn"
    //    }
    
    
}
 