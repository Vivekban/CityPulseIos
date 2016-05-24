//
//  LeaderVisiterBriefBar.swift
//  MyVoice
//
//  Created by PB014 on 14/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

let visitorResidentInfo = BriefBarInfo(items: [Constants.BriefItemUI_Issue_Raised,Constants.BriefItemUI_Badges], rect:CGRectMake(750, 10, 240, 80))
let visitorLeaderInfo = BriefBarInfo(items: [Constants.BriefItemUI_Follower,Constants.BriefItemUI_Issue_Resolved,Constants.BriefItemUI_Credits], rect: CGRectMake(386, 10, 240, 80))




class VisiterBriefBar: BriefProfileBar {

    override func setInfo(){
        switch (ptype) {
        case .Resident:
            info = visitorResidentInfo
            break;
        case .Leadear:
            info = visitorLeaderInfo
        }
    }
    
    override func getValueForCell(row : Int) ->Int {
        if let data = self.data {
            switch (ptype) {
            case .Resident:
                
                switch (row) {
                case 0:
                    return data.issueRaised
                case 1:
                    return data.badges
                case 2:
                    return data.badges
                default:
                    break;
                }
                
                break;
            case .Leadear:
                switch (row) {
                case 0:
                    return data.followers
                case 1:
                    return data.issueResolved
                case 2:
                    return data.credits
                case 3:
                    return data.donations
                case 4:
                    return data.credits
                case 5:
                    return data.reviews
                default:
                    break;
                }
            }
        }
        return 0
    }
    
   
    @IBAction func onButtonClick(sender: UIButton) {
        
        EventUtils.postNotification(EventUtils.briefBarActions, object: sender.tag)
        
        switch (sender.tag) {
        case 1:
            delegate?.onMessageClick?()
            break;
        case 2:
            delegate?.onFollowClick?()
            break
        case 3:
            delegate?.onReviewClick()
            break
        case 4:
            delegate?.onDonationClick?()
            break
        default:
            break;
        }
        
    }
    
}
