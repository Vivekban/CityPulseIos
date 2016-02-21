//
//  MyViewTableCell.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class MyViewTableCell: UICollectionViewCell {
    
    //MARK: Properties
    
    
    @IBOutlet weak var detailLabel: UILabel!
    
    
    @IBOutlet weak var dateField: UILabel!

    
    weak var touchDelegate:ListHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code
//        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("onHeaderClick:"))
//\        // to extend in case of more
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("onDetailLabelClick:"))
//        detailLabel.addGestureRecognizer(tapGesture2)
//        detailLabel.lineBreakMode = .ByWordWrapping
        
    }
    
    
    func onHeaderClick(gesture: UIGestureRecognizer){
        touchDelegate?.onHeaderClick(self.tag)
    }
    
    func onDetailLabelClick(gesture : UIGestureRecognizer){
        if detailLabel.numberOfLines > 0 {
            detailLabel.numberOfLines = 0
        }
        else{
            detailLabel.numberOfLines = 6
        }
        touchDelegate?.onDetailClick(self.tag)
    }
    
}








