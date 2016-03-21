//
//  BaseActivityCell.swift
//  MyVoice
//
//  Created by PB014 on 10/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


protocol ActivityCellDelegate : class {
    func onMoreButtonClick(sender : BaseActivityCell)
}

class BaseActivityCell: UICollectionViewCell {
    
    weak var delegate : ActivityCellDelegate?
    
    @IBAction func onMoreButtonClick(sender: AnyObject) {
        delegate?.onMoreButtonClick(self)
    }
}

class CreditsActivityCell: BaseActivityCell {
    
}

class ProfileActivityCell: BaseActivityCell {
    
}

class DonationActivityCell: BaseActivityCell {
    
}

class PageViewsActivityCell: BaseActivityCell {
    
}

class BadgesActivityCell : BaseActivityCell {
    
}