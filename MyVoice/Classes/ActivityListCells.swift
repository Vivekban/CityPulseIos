//
//  ActivityListCells.swift
//  MyVoice
//
//  Created by PB014 on 11/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class ActivityListCell: UITableViewCell {
    func updateViewsWithData(data : BaseData){
        
    }
}

class CreditsListCells: ActivityListCell {

    @IBOutlet weak var level: UILabel!
    
    @IBOutlet weak var creditsRequired: UILabel!
   
    @IBOutlet weak var privilageTitle: UILabel!
    @IBOutlet weak var privilageDetail: UILabel!
    
    override func updateViewsWithData(data : BaseData){
        if let d = data as? CreditsData {
            level.text = d.level.toString()
            creditsRequired.text = d.creditREquired.toString()
            privilageTitle.text = d.title
            privilageDetail.text = d.description
        }
    }

}


class DonationListCells: ActivityListCell {
    
    @IBOutlet weak var serialNo: UILabel!
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var actualAmout: UILabel!
    
    @IBOutlet weak var tranferStatus: UILabel!
    
    @IBOutlet weak var owner: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    override func updateViewsWithData(data : BaseData){
        if let d = data as? DonationData {
            serialNo.text = d.serialNo.toString()
            total.text = d.total.toString()
            actualAmout.text = d.actual.toString()

            tranferStatus.text = d.tranferredStatus
            owner.text = d.ownerName
            date.text = d.date

        }
    }
}


class BadgesListCells: ActivityListCell {
    
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var privilages: UILabel!
    
    override func updateViewsWithData(data : BaseData){
        if let d = data as? BadgesData {
            level.text = d.level.toString()
            count.text = d.count.toString()
            privilages.text = d.title
        }
    }
}



